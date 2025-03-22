# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: heimdall
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Install Firewall
include_recipe 'firewall'

# Setup Firewall Rule
firewall_rule 'Open Heimdall Port' do
  port node['cookbook']['heimdall']['port']
  protocol :tcp
  command :allow
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

# Heimdall Lite

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

# Open Heimdall in Browser
public_ip = `curl -fsS http://169.254.169.254/latest/meta-data/public-ipv4`
log "Open In Browser: $ open http://#{public_ip}:#{node['cookbook']['heimdall']['port']}"

# Heimdall Server

# git '~/heimdall2' do
#  repository 'https://github.com/mitre/heimdall2'
#  revision 'master'
#  action :sync
# end
#
# execute 'Setup Docker Env' do
#  command './setup-docker-env.sh'
#  cwd '~/heimdall2'
# end
#
# package %w(docker)
#
# execute 'Download Docker-Compose' do
#  command 'curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose'
# end
#
# execute 'Start Docker Container' do
#  command 'docker-compose up'
# end
