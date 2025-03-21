# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: heimdall
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Ensure firewalld is installed and running
# Ensure required packages are installed
package %w(curl git firewalld)

service 'firewalld' do
  action [:enable, :start]
end

# Open port 5005/tcp permanently
execute 'Open Heimdall Port' do
  command "firewall-cmd --permanent --add-port=#{node['cookbook']['heimdall']['port']}/tcp"
  not_if "firewall-cmd --list-ports | grep #{node['cookbook']['heimdall']['port']}/tcp"
  notifies :run, 'execute[Reload Firewall]', :immediately
end

# Reload firewalld to apply changes
execute 'Reload Firewall' do
  command 'firewall-cmd --reload'
  action :nothing
end

# Install Node.js and npm via EPEL or NodeSource
execute 'Setup NodeJS' do
  command 'curl -fsSL https://rpm.nodesource.com/setup_23.x | bash -'
  not_if 'which node'
end

# Install NodeJS
package 'Install NodeJS' do
  package_name 'nodejs'
  action :install
end

# Install heimdall-lite globally if not installed
execute 'Install Heimdall Lite' do
  command 'npm install -g @mitre/heimdall-lite'
  not_if 'npm list -g @mitre/heimdall-lite | grep heimdall-lite'
  # Remove Older NodeJS and Install Latest?
  notifies :remove, 'package[Install NodeJS]', :before
  notifies :install, 'package[Install NodeJS]', :before
end

# Create a systemd service to run Heimdall Lite
template 'Create Heimdall Lite Service File' do
  path '/etc/systemd/system/heimdall-lite.service'
  source 'heimdall-lite.service.erb'
  mode '0644'
  notifies :run, 'execute[Reload Systemd]', :immediately
  variables(port: node['cookbook']['heimdall']['port'])
end

# Reload systemd to register the new service
execute 'Reload Systemd' do
  command 'systemctl daemon-reexec && systemctl daemon-reload'
  action :nothing
end

# Enable and start Heimdall Lite
service 'Enable and Start Heimdall Lite' do
  service_name 'heimdall-lite'
  action [:enable, :start]
end
