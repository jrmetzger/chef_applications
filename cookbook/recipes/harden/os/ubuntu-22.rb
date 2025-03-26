# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: ubuntu-22
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node.default['cookbook']['controls']['audit'].tap do |control|
  control['active'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = ''
  end
end
