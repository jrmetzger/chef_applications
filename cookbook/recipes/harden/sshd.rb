# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sshd
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['sshd'].each do |name, control|
  next unless control['managed']

  line = "#{name} #{control['value']}"
  replace_or_add control['title'] do
    path '/etc/ssh/sshd_config'
    pattern /(^|#)#{name}/
    line line
    notifies :restart, 'service[sshd]', :delayed
  end
  service 'sshd' do
    action :nothing
  end
end
