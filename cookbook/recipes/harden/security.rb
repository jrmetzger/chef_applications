# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: security
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['security'].each do |name, control|
  next unless control['managed']

  case name
  when 'maxlogins'
    limit control['title'] do
      path "/etc/security/limits.d/99-chef-limits-#{name}.conf"
      domain '*'
      type 'hard'
      item name
      value control['value']
    end
  else
    line = control['value'].empty? ? name : "#{name} = #{control['value']}"
    replace_or_add control['title'] do
      path '/etc/security/pwquality.conf'
      pattern /(^|# )#{name}/
      line line
    end
  end
end
