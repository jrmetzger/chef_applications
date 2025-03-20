# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: grub
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['grub'].each do |_name, control|
  control['arg'].each do |key, value|
    entry = "#{key}=#{value}"
    execute control['title'] do
      command "grubby --update-kernel=ALL --args=#{entry}"
      not_if "grubby --info=ALL | grep #{entry}"
    end
    add_to_list control['title'] do
      path '/etc/default/grub'
      pattern 'GRUB_CMDLINE_LINUX="'
      delim [',']
      entry entry
      ends_with '"'
    end
  end
end
