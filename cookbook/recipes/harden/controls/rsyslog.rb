# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: rsyslog
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['rsyslog'].each do |name, control|
  next unless control['managed']

  case name
  when 'rsyslog-gnutls'
    package name
  else
    append_if_no_line control['title'] do
      path '/etc/rsyslog.conf'
      line control['value']
    end
  end
end
