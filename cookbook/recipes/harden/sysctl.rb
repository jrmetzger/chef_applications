# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sysctl
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['sysctl'].each do |_name, control|
  control['config'].each do |key, value|
    sysctl control['title'] do
      key key
      value value
    end
  end
end
