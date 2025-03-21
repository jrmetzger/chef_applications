#!/bin/bash
export PATH="/opt/cinc-workstation/embedded/bin:~/.chef/gem/ruby/3.1.0/bin:$PATH"

# Check if REDHAT_USERNAME and REDHAT_PASSWORD are set
if [ -z "$REDHAT_USERNAME" ] || [ -z "$REDHAT_PASSWORD" ]; then
  echo "ERROR: REDHAT_USERNAME and REDHAT_PASSWORD must be set."
  echo "Please export these variables before running the script."
  exit 1
fi

# Chef
command -v ruby &> /dev/null || { echo "Ruby not found, installing..."; brew install ruby; }
command -v qemu-img &> /dev/null || { echo "QEMU not found, installing..."; brew install qemu; }
brew list --cask | grep -q cinc-workstation || { echo "Cinc Workstation not found, installing..."; brew install --cask cinc-workstation; }
command -v vagrant &> /dev/null || { echo "Vagrant not found, installing..."; brew install --cask vagrant; }
command -v yq &> /dev/null || { echo "YQ not found, installing..."; brew install yq; }
vagrant plugin list | grep -q vagrant-qemu || { echo "Vagrant-QEMU plugin not found, installing..."; vagrant plugin install vagrant-qemu; }
test -f "cookbook/Gemfile.lock" || { echo "Gemfile Lock not found, installing..."; (cd cookbook && bundle install); }

# Heimdall
#brew install npm
#npm install -g @mitre/heimdall-lite
#heimdall-lite &
#echo Upload 'spec/results/rhel-9_default.json' to 'localhost:8000'

# curl -# -s -F data=@spec/results/rhel-9_default.json -F "filename=rhel-9_default" -F "public=true" -F "evaluationTags=8438b61,mitre/redhat-enterprise-linux-8-stig-baseline,DISA Hardened EC2 Testing Matrix,'Supplemental Automation Content v1r12'" -H "Authorization: Api-Key test" "http://localhost:8000/evaluations"


#lsof -i :$PORT
#kill -9 $PID

run_kitchen() {
  (cd cookbook && bundle exec kitchen "$@")
}

run_cookstyle() {
   (cd cookbook && bundle exec cookstyle -a)
}

if [ "$1" == "cv" ]; then
  command='converge verify'
elif [ "$1" == 'dv' ]; then
  command='destroy verify'
else
  command="$@"
fi

run_cookstyle
echo "Running: $comamnd"
for action in $command; do
  run_kitchen "$action"
done