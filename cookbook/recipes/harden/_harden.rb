# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: harden
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['controls'].each do |typ, control|
  log "-> Applying Group Controls: #{typ}"
  control.each do |name, configuration|
    log "--> Applying Control: #{name} - #{configuration['title']}" if configuration['managed']
  end
end

include_recipe 'cookbook::audit'
include_recipe 'cookbook::grub'
include_recipe 'cookbook::logindefs'
include_recipe 'cookbook::modprobe'
# include_recipe 'cookbook::mount'
include_recipe 'cookbook::security'
include_recipe 'cookbook::sshd'
include_recipe 'cookbook::sysctl'
include_recipe 'cookbook::systemd'
