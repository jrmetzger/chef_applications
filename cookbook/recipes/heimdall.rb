# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: heimdall
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# Source: https://supermarket.chef.io/cookbooks/docker
# Source: https://saf.mitre.org/docs/heimdall-install

# docker run -d -p 8080:80 mitre/heimdall-lite:release-latest

docker_service 'default' do
  action [:create, :start]
end

docker_image 'mitre/heimdall-lite:release-latest' do
  action :pull
end

docker_container 'Heimdall Server' do
  repo 'mitre/heimdall-lite:release-latest'
  port '8080:80'
  command 'nc -ll -p 1234 -e /bin/cat'
end
