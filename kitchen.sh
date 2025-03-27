#!/bin/bash

# Prerequisites

if [ ! -d /opt/cinc ]; then
  curl -L https://omnitruck.cinc.sh/install.sh | sudo bash
else
  echo "CINC already exists, skipping installation."
fi
if [ ! -d /opt/cinc-auditor ]; then
  curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -P cinc-auditor -v 6
else
  echo "CINC Auditor already exists, skipping installation."
fi
if [ ! -d /opt/cinc-workstation ]; then
  curl -L https://omnitruck.cinc.sh/install.sh | sudo bash -s -- -v 18 | sudo bash
else
  echo "CINC Workstation already exists, skipping installation."
fi
# brew list --cask | grep -q awscli || { echo "AWS Cli not found, installing..."; brew install awscli; }

# GEMS
test -f "cookbook/Gemfile.lock" || { echo "Gemfile Lock not found, installing..."; (cd cookbook && bundle install); }

# PATH
export PATH="/opt/cinc-auditor/bin:/opt/cinc-workstation/bin:/opt/cinc-workstation/embedded/bin:$PATH"


# ENV
REQUIRED_VARS=(
"REDHAT_USERNAME"
"REDHAT_PASSWORD"
"AWS_ACCESS_KEY_ID"
"AWS_SECRET_ACCESS_KEY"
"AWS_SSH_KEY_NAME"
"SUBNET_ID"
"IMAGE_ID_AMAZON2023"
"IMAGE_ID_REDHAT9"
"IMAGE_ID_UBUNTU22"
"INSTANCE_TYPE"
"SECURITY_GROUP_ID"
  )
for var in "${REQUIRED_VARS[@]}"; do
  [ -z "${!var}" ] && echo "ERROR: $var is not set." && missing=true
done
[ "$missing" ] && echo "Please export the missing variables." && exit 1

# KITCHEN
run_kitchen() {
  (cd cookbook && bundle exec kitchen "$@" --concurrency=2) # -l debug)
}

run_cookstyle() {
  (cd cookbook && bundle exec cookstyle -a)
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