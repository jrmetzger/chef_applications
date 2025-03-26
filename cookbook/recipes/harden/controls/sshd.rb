# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sshd
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['sshd'].each do |name, control|
  next unless control['managed']

  case name
  when 'CLI_Login_Banner'
    file control['title'] do
      path 'etc/issue'
      content control['content']
    end

  else
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
end
