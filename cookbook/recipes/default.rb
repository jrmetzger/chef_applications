# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['applications'].each do |app|
  include_recipe "cookbook::#{app}"
end
