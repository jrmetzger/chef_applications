# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: aide
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['aide'].each do |name, control|
  next unless control['managed']

  # Packages
  case name
  when 'package'
    package 'aide'
    execute 'Initialize AIDE Database' do
      command 'aide --init'
      not_if { ::File.exist?('/var/lib/aide/aide.db.gz ') }
    end
  else
    control['values'].each do |value|
      append_if_no_line control['title'] do
        path control['path'] || '/etc/aide.conf'
        line value
      end
    end
  end
end
