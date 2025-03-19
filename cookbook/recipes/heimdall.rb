# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: heimdall
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Source: https://supermarket.chef.io/cookbooks/docker

package %w(git)

docker_service 'default' do
  action [:create, :start]
end

# docker run -d -p 8080:80 mitre/heimdall-lite:release-latest
# docker_image 'mitre/heimdall-lite:release-latest' do
#  action :pull
# end
# docker_container 'Heimdall Server' do
#  repo 'mitre/heimdall-lite:release-latest'
#  port '8080:80'
#  command 'nc -ll -p 1234 -e /bin/cat'
# end

# Source: https://github.com/mitre/heimdall2
git 'Clone Heimdall2' do
  repository 'https://github.com/mitre/heimdall2'
  destination "#{Chef::Config[:file_cache_path]}/Heimdall2"
end

execute 'Setup Heimdall2' do
  command './setup-docker-env.sh'
  cwd "#{Chef::Config[:file_cache_path]}/Heimdall2"
end

execute 'Startup Heimdall2' do
  command 'docker compose up'
  cwd "#{Chef::Config[:file_cache_path]}/Heimdall2"
end
