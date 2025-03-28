# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: selinux
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['selinux'].each do |_name, control|
  next unless control['managed']
end
