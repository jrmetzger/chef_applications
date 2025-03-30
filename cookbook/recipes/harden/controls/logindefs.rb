# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: logindefs
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['logindefs'].each do |name, control|
  next unless control['managed']

  case name
  when 'INACTIVE'
    # /etc/defaults/useradd
    execute 'set_default_inactivity' do
      command "useradd -D -f #{control['value']}"
      not_if "useradd -D | grep -q 'INACTIVE=#{control['value']}'"
    end
  else
    line = control['value'].empty? ? name : "#{name} #{control['value']}"
    replace_or_add control['title'] do
      path '/etc/login.defs'
      pattern /(^|#)#{name}/
      line line
    end
  end
end
