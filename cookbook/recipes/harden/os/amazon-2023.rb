# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: amazon-2023
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node.default['cookbook']['harden']['controls'].tap do |controls|
  controls['systemd'].tap do |control|
    control['kdump'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-257818: The kdump service on RHEL 9 must be disabled.'
      configuration['actions'] = %w(disable)
    end
  end
end
