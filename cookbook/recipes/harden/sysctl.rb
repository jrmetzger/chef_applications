# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sysctl
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['sysctl'].each do |key, control|
  next unless control['managed']
  sysctl control['title'] do
    key key
    value control['value']
  end
end
