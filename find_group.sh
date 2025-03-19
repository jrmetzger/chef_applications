#/bin/bash

jq -r '.profiles[0].controls[].descriptions[0].data' ./cookbook/spec/results/rhel-9_default.json
