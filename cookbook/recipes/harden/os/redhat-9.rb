# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: redhat-9
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node.default['cookbook']['harden']['controls'].each do |_group, controls|
  controls['audit'].tap do |control|
    control['active'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258145: RHEL 9 must be configured to offload audit records onto a different system from the system being audited via syslog.'
    end
  end

  controls['packages'].tap do |control|
    control['fapolicyd'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258089: RHEL 9 fapolicy module must be installed.'
    end
  end

  controls['rsyslog'].tap do |control|
    control['rsyslog-gnutls'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258141: RHEL 9 must have the packages required for encrypting offloaded audit logs installed.'
    end
  end

  controls['systemd'].tap do |control|
    control['kdump'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-257818: The kdump service on RHEL 9 must be disabled.'
      configuration['actions'] = %w(disable)
    end
  end
end
