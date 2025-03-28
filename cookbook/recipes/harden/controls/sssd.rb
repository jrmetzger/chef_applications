# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sssd
#
# Copyright:: 2025, The Authors, All Rights Reserved.

package 'sssd'

service 'sssd' do
  action [:enable, :start]
end

node['cookbook']['harden']['controls']['sssd'].each do |name, control|
  next unless control['managed']

  case name
  when 'pki_authentication'
    template control['title'] do
      path '/etc/sssd/sssd.conf'
      source 'sssd.conf.erb'
    end
  end
end
