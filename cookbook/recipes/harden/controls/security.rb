# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: security
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['security'].each do |name, control|
  next unless control['managed']

  case name
  when 'maxlogins'
    limit control['title'] do
      path "/etc/security/limits.d/99-chef-limits-#{name}.conf"
      domain '*'
      type 'hard'
      item name
      value control['value']
    end
    next
  when 'selinux'
    selinux_state 'Set SELinux to enforcing' do
      action control['action']
    end
    next

  when 'dir'
    directory '/var/log/faillock'
    execute 'semanage fcontext -a -t faillog_t "/var/log/faillock(/.*)?"'
  end

  path = case name
         when 'deny', 'even_deny_root', 'fail_interval', 'unlock_time', 'audit', 'dir'
           '/etc/security/faillock.conf'
         else
           '/etc/security/pwquality.conf'
         end

  line = control['value'].empty? ? name : "#{name} = #{control['value']}"
  replace_or_add control['title'] do
    path path
    pattern(/(^|# )#{name}/)
    line line
    replace_only true
  end
end
