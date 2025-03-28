# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: harden
#
# Copyright:: 2025, The Authors, All Rights Reserved.

os_name = "#{node['platform']}-#{node['platform_version'].to_i}"

log "------> Applying #{node['cookbook']['harden']['standard']}} to OS: #{os_name}"
include_recipe "cookbook::#{os_name}"
node['cookbook']['harden']['controls'].each do |group, controls|
  next unless node['cookbook']['harden']['override_control_groups'].include?(group)
  log "-> Applying Group Controls: #{group}"
  controls.each do |name, control|
    control['title'] = control[os_name] if control.key?(os_name)
    log "--> Applying Control: #{name} - #{control['title']}" if control['managed']
  end
end

log '-----> Running Hardening Recipes:'
node['cookbook']['harden']['control_groups'].each do |group, managed|
  next unless node['cookbook']['harden']['override_control_groups'].include?(group)
  include_recipe "cookbook::#{group}" unless managed == false
end
