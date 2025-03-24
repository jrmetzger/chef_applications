# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: habitat
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# To Uninstall

# directory '/hab' do
#  recursive true
#  action :delete
# end

# https://bldr.habitat.sh/#/pkgs/core

selinux_state 'permissive' do
  action :permissive
end

# Ensure Habitat is installed
# https://docs.chef.io/resources/habitat_install/
habitat_install 'hab' do
  license 'accept'
  action :install
  not_if 'which hab'
end

# Start the Habitat Supervisor service
# https://docs.chef.io/resources/habitat_sup/
habitat_sup 'default' do
  action :run
end

node['cookbook']['habitat']['apps'].each do |name, apps|
  next unless apps['managed']

  full_name = "#{apps['group']}/#{name}"

  # Install a Habitat package
  # https://docs.chef.io/resources/habitat_package/
  habitat_package full_name do
    binlink :force
    action :install
  end

  # Ensure the Habitat service is running
  # https://docs.chef.io/resources/habitat_service/
  habitat_service full_name do
    action :load
  end

  # Configuration
  # https://docs.chef.io/resources/habitat_config/
  habitat_config "#{name}.default" do
    config(apps['config'])
    action :apply
  end

  # User Toml
  # https://docs.chef.io/resources/habitat_user_toml/
  habitat_user_toml full_name do
    config(apps['user_toml'])
    action :create
  end
end
