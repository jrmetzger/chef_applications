# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: redhat-9
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node.default['cookbook']['controls']['audit'].tap do |control|
  control['fapolicyd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258089: RHEL 9 fapolicy module must be installed.'
  end
  control['fapolicyd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258089: RHEL 9 fapolicy module must be installed.'
  end
  control['rsyslog-gnutls'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258141: RHEL 9 must have the packages required for encrypting offloaded audit logs installed.'
  end
end
