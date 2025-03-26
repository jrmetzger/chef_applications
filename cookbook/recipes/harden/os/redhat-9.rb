# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: redhat-9
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node.default['cookbook']['controls']['audit'].tap do |control|
  control['active'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258145: RHEL 9 must be configured to offload audit records onto a different system from the system being audited via syslog.'
  end
end
