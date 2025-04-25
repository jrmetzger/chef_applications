# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: audit
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# execute 'SV-258241: RHEL 9 must implement a system-wide encryption policy.' do
#  command 'update-crypto-policies --set FIPS'
#  not_if 'test $(cat /proc/sys/crypto/fips_enabled) -eq 1'  # Skip if already in FIPS mode
# end

node['cookbook']['harden']['controls']['audit'].each do |name, control|
  next unless control['managed']

  # Packages
  package control['package'] if control['package']

  # Configuration
  next unless control['value']

  pattern = "^#{name} = .*"
  line = "#{name} = #{control['value']}"
  replace_or_add control['title'] do
    path control['path'] || '/etc/audit/auditd.conf'
    pattern pattern
    line line
  end
end

# Rules
file '/etc/audit/rules.d/audit.rules' do
  action :delete
end
template 'Implement Audit Controls' do
  path '/etc/audit/rules.d/99-stig.rules'
  source 'audit.rules.erb'
  mode '0644'
  owner 'root'
  group 'root'
  notifies :run, 'execute[Reload Auditctl]', :immediately
  variables(rules: node['cookbook']['harden']['controls']['audit'])
end
execute 'Reload Auditctl' do
  command 'augenrules --load'
  # command 'auditctl -R /etc/audit/rules.d/99-stig.rules'
  # reboot
  action :nothing
end

# sudo augenrules --load
# sudo systemctl restart auditd
