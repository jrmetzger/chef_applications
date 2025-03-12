#!/bin/bash
export PATH="/opt/cinc-workstation/embedded/bin:~/.chef/gem/ruby/3.1.0/bin:$PATH"

# Check if REDHAT_USERNAME and REDHAT_PASSWORD are set
if [ -z "$REDHAT_USERNAME" ] || [ -z "$REDHAT_PASSWORD" ]; then
  echo "ERROR: REDHAT_USERNAME and REDHAT_PASSWORD must be set."
  echo "Please export these variables before running the script."
  exit 1
fi

command -v ruby &> /dev/null || { echo "Ruby not found, installing..."; brew install ruby; }
command -v qemu-img &> /dev/null || { echo "QEMU not found, installing..."; brew install qemu; }
brew list --cask | grep -q cinc-workstation || { echo "Cinc Workstation not found, installing..."; brew install --cask cinc-workstation; }
command -v vagrant &> /dev/null || { echo "Vagrant not found, installing..."; brew install --cask vagrant; }
command -v yq &> /dev/null || { echo "YQ not found, installing..."; brew install yq; }
vagrant plugin list | grep -q vagrant-qemu || { echo "Vagrant-QEMU plugin not found, installing..."; vagrant plugin install vagrant-qemu; }
test -f "cookbook/Gemfile.lock" || { echo "Gemfile Lock not found, installing..."; (cd cookbook && bundle install); }
(cd cookbook && bundle exec kitchen $@)