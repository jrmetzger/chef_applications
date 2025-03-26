# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: logindefs
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['logindefs'].each do |name, control|
  next unless control['managed']

  line = control['value'].empty? ? name : "#{name} #{control['value']}"
  replace_or_add control['title'] do
    path '/etc/login.defs'
    pattern /(^|#)#{name}/
    line line
  end
end
