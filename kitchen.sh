#!/bin/bash
#export PATH"
#export PATH="/opt/cinc-workstation/embedded/bin:~/.chef/gem/ruby/3.1.0/bin:$PATH"

#gem install bundler
#test -f "cookbook/Gemfile.lock" || { echo "Gemfile Lock not found, installing..."; (cd cookbook && bundle install); }

#Powershell
#"PATH="/opt/homebrew/opt/ruby/bin:/opt/cinc-workstation/embedded/bin:~/.chef/gem/ruby/3.1.0/bin:$PATH"


# Ruby
#command -v ruby &> /dev/null || { echo "Ruby not found, installing..."; brew install ruby; }

# Chef
#
# Vagrant
#command -v vagrant &> /dev/null || { echo "Vagrant not found, installing..."; brew install --cask vagrant; }
#vagrant plugin list | grep -q vagrant-qemu || { echo "Vagrant-QEMU plugin not found, installing..."; vagrant plugin install vagrant-qemu; }
# Qemu
#command -v qemu-img &> /dev/null || { echo "QEMU not found, installing..."; brew install qemu; }

# Tools
#command -v yq &> /dev/null || { echo "YQ not found, installing..."; brew install yq; }

# brew install rbenv
# rbenv install 3.2.2
# rbenv global 3.2.2

#for gem in test-kitchen kitchen-ec2 kitchen-vagrant kitchen-inspec; do
#  if ! gem list -i "$gem" > /dev/null 2>&1; then
#    echo "Installing $gem..."
#    gem install "$gem" --no-document
#  fi
#done

# Bundle
#gem cleanup
#gem install bundler
#
# Heimdall
#brew install npm
#npm install -g @mitre/heimdall-lite
#heimdall-lite &
#echo Upload 'spec/results/rhel-9_default.json' to 'localhost:8000'

# curl -# -s -F data=@spec/results/rhel-9_default.json -F "filename=rhel-9_default" -F "public=true" -F "evaluationTags=8438b61,mitre/redhat-enterprise-linux-8-stig-baseline,DISA Hardened EC2 Testing Matrix,'Supplemental Automation Content v1r12'" -H "Authorization: Api-Key test" "http://localhost:8000/evaluations"


#
#kill -9 $(lsof -i :12345)

# Required
brew list --cask | grep -q cinc-workstation || { echo "Cinc Workstation not found, installing..."; brew install --cask cinc-workstation; }
# brew list --cask | grep -q awscli || { echo "AWS Cli not found, installing..."; brew install awscli; }
export PATH="/opt/cinc-workstation/bin:/opt/cinc-workstation/embedded/bin:$PATH"
test -f "cookbook/Gemfile.lock" || { echo "Gemfile Lock not found, installing..."; (cd cookbook && bundle install); }

# List of required environment variables
REQUIRED_VARS=(
"REDHAT_USERNAME"
"REDHAT_PASSWORD"
"AWS_ACCESS_KEY_ID"
"AWS_SECRET_ACCESS_KEY"
"AWS_SSH_KEY_NAME"
"SUBNET_ID"
"IMAGE_ID"
"INSTANCE_TYPE"
"SECURITY_GROUP_ID"
  )

# Check if any are missing
for var in "${REQUIRED_VARS[@]}"; do
  [ -z "${!var}" ] && echo "ERROR: $var is not set." && missing=true
done

# Exit if any variable is missing
[ "$missing" ] && echo "Please export the missing variables." && exit 1


#####

run_kitchen() {
  (cd cookbook && bundle exec kitchen "$@") # -l debug)
  #(cd cookbook && kitchen "$@")
}

run_cookstyle() {
  (cd cookbook && bundle exec cookstyle -a)
  #(cd cookbook && cookstyle -a)
}

case "$1" in
  c)
    command="converge"
    ;;
  cv)
    command="converge verify"
    ;;
  dv)
    command="destroy verify"
    ;;
  *)
    command="$*"
    ;;
esac


#if [ "$1" == "c" ]; then
#  command"
#if [ "$1" == "cv" ]; then
#  command"
#elif [ "$1" == 'dv' ]; then
#  command"
#else
#  command="$@"
#fi

run_cookstyle
echo "Running: $comamnd"
for action in $command; do
  run_kitchen "$action"
done