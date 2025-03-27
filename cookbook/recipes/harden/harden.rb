# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: harden
#
# Copyright:: 2025, The Authors, All Rights Reserved.

os_name = "#{node['platform']}-#{node['platform_version'].to_i}"

log "------> Applying to OS: #{os_name}"
include_recipe "cookbook::#{os_name}"
node.default['cookbook']['harden']['controls'].each do |_group, controls|
  controls.each do |_name, control|
    control['title'] = control[os_name] if control.key?(os_name)
  end
end

log "-----> Applying #{node['cookbook']['harden']['standard']} Standards"
node['cookbook']['harden']['controls'].each do |group, control|
  next unless node['cookbook']['harden']['control_groups'][group]
  log "-> Applying Group Controls: #{group}"
  control.each do |name, configuration|
    log "--> Applying Control: #{name} - #{configuration['title']}" if configuration['managed']
  end
end

log '------> Setting SELinux to Permissive'
selinux_state 'permissive' do
  action :permissive
end

log '-----> Running Hardening Recipes:'
node['cookbook']['harden']['control_groups'].each do |group, managed|
  group_name = File.basename(group, '.rb')
  include_recipe "cookbook::#{group_name}" unless managed == false
end
