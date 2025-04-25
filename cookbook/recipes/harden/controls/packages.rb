# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: logindefs
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Install Epel-Release
# remote_file 'Download EPEL Release Repository' do
#  path '/tmp/epel-release-latest-8.noarch.rpm'
#  source 'https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm'
# end
# package 'Install EPEL Release Repository' do
#  package_name 'epel-release'
#  source '/tmp/epel-release-latest-8.noarch.rpm'
# end

node['cookbook']['harden']['controls']['packages'].each do |name, control|
  next unless control['managed']

  service_name = nil
  package_name = nil
  action_name = :install

  case name
  when 'main.localpkg_gpgcheck'
    _stanza, key = name.split('.')
    line = "#{key}=#{control['value']}"
    replace_or_add control['title'] do
      path '/etc/dnf/dnf.conf'
      pattern(/^#{key}/)
      line line
    end
    next

  when 'usbguard', 'fapolicyd', 'rsyslog'
    service_name = name
    package_name = name
  when 'EndpointSecurity'
    service_name = control['service']
    package_name = control['package']
  when 'nfs-utils', 'gssproxy', 'tuned'
    package_name = name
    action_name = :remove
  else
    package_name = name
    service_name = control['service'] if control['service']
  end

  package control['title'] do
    package_name package_name
    action action_name
    # notifies :enable, "service[#{control['title']}]", :immediately if service_name
  end

  log service_name if service_name
  # service control['title'] do
  #  service_name service_name
  #  action [:enable, :start]
  #  only_if { service_name }
  # end
end
