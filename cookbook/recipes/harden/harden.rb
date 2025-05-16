# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: harden
#
# Copyright:: 2025, The Authors, All Rights Reserved.

os_name = "#{node['platform']}-#{node['platform_version'].to_i}"

# parts = output.split(/\s*\|\s*/).reject(&:empty?) # Splitting and cleaning up
# formatted_output = parts.map { |part| part.ljust(10) }.join("|")

filter_lines 'Need to accept login with PAM' do
  path '/etc/pam.d/sshd'
  filters(substitute: [/account.*required.*pam_nologin.so/, /^ /, '#'])
end

puts "-----> Applying #{node['cookbook']['harden']['standard']}} to OS: #{os_name}"
include_recipe "cookbook::#{os_name}"

puts '-----> | Group | Control | Title |'
node['cookbook']['harden']['controls'].each do |group, controls|
  # next unless node['cookbook']['harden']['override_control_groups']&.include?(group)

  controls.each do |name, control|
    control['title'] = control[os_name] if control.key?(os_name)
    next unless control['managed']

    # id, title = control['title'].split(':')
    puts "-----> | #{group} | #{name} | #{control['title']} | "
  end

  include_recipe "cookbook::#{group}" # unless node['cookbook']['harden']['control_groups'][group]
end
