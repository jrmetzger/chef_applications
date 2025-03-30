# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: chrony
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['chrony'].each do |name, control|
  next unless control['managed']

  replace_or_add control['title'] do
    path '/etc/chrony.conf'
    pattern /"^#{name}"/
    line "#{name} #{control['value']}"
  end
end
