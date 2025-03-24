# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: grub
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls']['grub'].each do |name, control|
  next unless control['managed']

  case name

  when 'fips'
    execute control['title'] do
      command [
        "fips-mode-setup --#{control['mode']}",
        'ln -sf /usr/share/crypto-policies/FIPS/nss.txt /etc/crypto-policies/back-ends/nss.txt',
      ]
      only_if { name == 'fips' }
      not_if 'update-crypto-policies --show | grep FIPS'
    end

  else

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
end
