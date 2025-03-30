# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: pamd
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['pamd'].each do |_name, control|
  next unless control['managed']
end
