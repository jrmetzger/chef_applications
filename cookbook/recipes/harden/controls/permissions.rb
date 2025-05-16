# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: permissions
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['permissions'].each do |name, control|
  next unless control['managed']

  case name
  when 'library_files'
    `find -L /lib /lib64 /usr/lib /usr/lib64 ! -group #{control['group']}`.split.each do |fpath|
      execute "#{control['title']} - #{fpath}" do
        command "chgrp #{control['group']} $(readlink -f #{fpath})"
      end
    end
  end
end
