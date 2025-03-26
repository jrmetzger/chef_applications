# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: amazon-2023
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node.default['cookbook']['controls']['audit'].tap do |control|
  control['active'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = ''
  end
end
