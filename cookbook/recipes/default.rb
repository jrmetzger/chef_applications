# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# execute 'SV-258241: RHEL 9 must implement a system-wide encryption policy.' do
#  command 'update-crypto-policies --set FIPS'
#  not_if 'test $(cat /proc/sys/crypto/fips_enabled) -eq 1'  # Skip if already in FIPS mode
# end

template '/etc/audit/rules.d/99-stig.rules' do
  source 'audit.rules.erb'
  mode '0644'
  owner 'root'
  group 'root'
  notifies :run, 'execute[Reload Auditctl]', :immediately
  variables(rules: node['cookbook']['controls']['audit'])
end
execute 'Reload Auditctl' do
  command 'auditctl -R /etc/audit/rules.d/99-stig.rules'
end
