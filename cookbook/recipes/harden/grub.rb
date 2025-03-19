# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: grub
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['grub'].each do |_name, control|
  execute control['title'] do
    command "grubby --update-kernel=ALL --args=#{control['arg']}"
    not_if "grubby --info=ALL | grep #{control['arg']}"
  end
end
