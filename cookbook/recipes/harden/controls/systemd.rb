# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: systemd
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['systemd'].each do |name, control|
  next unless control['managed']

  stanza, key = name.split('.')

  case stanza
  when 'Manager', 'Coredump'
    fname = case stanza
            when 'Manger'
              'system'
            when 'Coredump'
              'coredump'
            end
    # filter_lines control['title'] do
    #  path "/etc/systemd/#{fname}.conf"
    #  filters([
    #    { stanza: [stanza, { "#{key}": control['value'] } ] },
    #  ])
    # end

    line = "#{key}=#{control['value']}"
    replace_or_add control['title'] do
      path "/etc/systemd/#{fname}.conf"
      pattern(/(^|#)#{key}/)
      line line
    end
  else
    control['actions'].each do |action|
      service "#{control['title']} - #{action}" do
        service_name name
        action action.to_sym
      end
    end
  end
end
