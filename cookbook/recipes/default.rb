# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: default
#
# Copyright:: 2025, The Authors, All Rights Reserved.

include_recipe 'cookbook::_harden'
include_recipe 'cookbook::heimdall'
include_recipe 'cookbook::habitat'
