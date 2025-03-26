# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: harden
#
# Copyright:: 2025, The Authors, All Rights Reserved.

log "Applying to OS: #{node['platform']}-#{node['platform_version'].to_i}"
include_recipe "cookbook::#{node['platform']}-#{node['platform_version'].to_i}"

node['cookbook']['harden']['controls'].each do |group, control|
  next unless node['cookbook']['harden']['control_groups'][group]
  log "-> Applying Group Controls: #{group}"
  control.each do |name, configuration|
    log "--> Applying Control: #{name} - #{configuration['title']}" if configuration['managed']
  end
end

selinux_state 'permissive' do
  action :permissive
end

node['cookbook']['harden']['control_groups'].each do |group, managed|
  group_name = File.basename(group, '.rb')
  include_recipe "cookbook::#{group_name}" unless managed == false
end
