#!/bin/bash

chef_client_version=18
chef_auditor_version=6
chef_workstation_version=24
chef_server_version=15
chef_default_provider='qemu'

# Prerequisites

# https://cinc.sh/start/client/
if [[ ! (-d /opt/cinc || -d /opt/chef) ]]; then
  echo "[INFO] Installing Chef"
  sudo curl -L https://omnitruck.cinc.sh/install.sh | bash -s -- -v $chef_client_version
fi

# https://cinc.sh/start/auditor/
if [[ ! (-d /opt/cinc-auditor || -f /opt/chef-workstation/bin/inspec) ]]; then
  echo "[INFO] Installing Chef Auditor"
  curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor -v $chef_auditor_version
fi

# https://cinc.sh/start/workstation/
if [[ ! (-d /opt/cinc-workstation || -d /opt/chef-workstation) ]]; then
  echo "[INFO] Installing Chef Workstation"
  curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-workstation -v $chef_workstation_version
fi

# https://cinc.sh/start/server/
# NOT SUPPORT ON MAC
#if [ ! -d /opt/cinc-server ]; then
#  echo "[INFO] Installing Chef Server"
#  curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-server #-v $chef_server_version
#fi

# Install VMware Fusion

# PATH
export PATH="/opt/homebrew/opt/ruby@3.4/bin/:/opt/cinc-auditor/bin:/opt/cinc-workstation/bin:/opt/cinc-workstation/embedded/bin:$PATH"
# export PATH="/opt/chef-workstation/bin:/opt/chef-workstation/embedded/bin:$PATH"
export VAGRANT_DEFAULT_PROVIDER=$chef_default_provider

# GEMS
#test -f "cookbook/Gemfile.lock" || { echo "Gemfile Lock not found, installing..."; (cd cookbook && bundle install); }

# ENV
REQUIRED_VARS=(
# RHEL
"REDHAT_USERNAME"
"REDHAT_PASSWORD"
# EC2
#"AWS_ACCESS_KEY_ID"
#"AWS_SECRET_ACCESS_KEY"
#"AWS_SSH_KEY_NAME"
#"SUBNET_ID"
#"IMAGE_ID_AMAZON2023"
#"IMAGE_ID_REDHAT9"
#"IMAGE_ID_UBUNTU22"
#"INSTANCE_TYPE"
#"SECURITY_GROUP_ID"
#"REGION"
  )
for var in "${REQUIRED_VARS[@]}"; do
  [ -z "${!var}" ] && echo "ERROR: $var is not set." && missing=true
done
[ "$missing" ] && echo "Please export the missing variables." && exit 1

# KITCHEN
run_kitchen() {
  (cd cookbook && kitchen "$@") # --concurrency=2) # -l debug)
}

run_cookstyle() {
  (cd cookbook && cookstyle -a)
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
    command="$1"
    ;;
esac

suites=$2

run_cookstyle
for action in $command; do
  echo "-----> Running $action /$suites/"
  run_kitchen $action $suites
done
