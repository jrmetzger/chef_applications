# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: grub
#
# Copyright:: 2025, The Authors, All Rights Reserved.

execute 'update-grub' do
  command 'grub2-mkconfig -o /boot/grub2/grub.cfg'
  action :nothing
end

reboot 'Restart System' do
  action :nothing
end

node['cookbook']['harden']['controls']['grub'].each do |name, control|
  next unless control['managed']

  case name

  when 'fips'
    execute control['title'] do
      command "fips-mode-setup --#{control['mode']}"
      # 'ln -sf /usr/share/crypto-policies/FIPS/nss.txt /etc/crypto-policies/back-ends/nss.txt',
      # ]
      not_if 'update-crypto-policies --show | grep FIPS'
      # notifies :request_reboot, 'reboot[Restart System]', :immediately
    end

  when 'boot_loader_superuser_name'
    filter_lines configuration['title'] do
      path'/etc/grub2.cfg'
      filters([
       { substitute: [/set superusers/, /root/, control['value']] },
       { substitute: [/password_pbkdf2.*${GRUB2_PASSWORD}/, /root/, control['value']] },
       ])
      notifies :run, 'execute[update-grub]', :delayed
    end
    next

  when 'boot_loader_superuser_password'
    file control['title'] do
      path '/boot/grub2/user.cfg'
      content "GRUB2_PASSWORD=#{control['value']}"
      notifies :run, 'execute[update-grub]', :delayed
    end
    next
  end

  entry = "#{name}=#{control['value']}"
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
