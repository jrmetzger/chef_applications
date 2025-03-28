# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: usbguard
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['usbguard'].each do |name, control|
  next unless control['managed']

  case name
  when 'generate_policy'
    execute control['title'] do
      command 'usbguard generate-policy --no-hash > /etc/usbguard/rules.conf'
    end
  end
end
