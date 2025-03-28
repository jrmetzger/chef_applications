# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sysctl
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['sysctl'].each do |key, control|
  next unless control['managed']

  # %w(
  # /etc/sysctl.d/*.conf
  # /run/sysctl.d/*.conf
  # /usr/local/lib/sysctl.d/*.conf
  # /usr/lib/sysctl.d/*.conf
  # /lib/sysctl.d/*.conf
  # /etc/sysctl.conf
  # ).each do |paths|
  #   Dir.glob(paths).each do |path|
  #     delete_lines "Delete Duplicate sysctl configuration for #{key}" do
  #       path path
  #       pattern /^#{key}.*=/
  #     end
  #   end
  # end

  sysctl control['title'] do
    key key
    value control['value']
  end
end
