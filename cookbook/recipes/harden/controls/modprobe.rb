# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: modprobe
#
# Copyright:: 2025, The Authors, All Rights Reserved.

node['cookbook']['harden']['controls']['modprobe'].each do |name, control|
  next unless control['managed']

  # NOTE: Can be in /etc/modprobe.d/99-chef-#{name}
  # NOTE: Can be a template in /etc/modprobe.d/99-chef-harden
  # NOTE: Some require /etc/modeprobe.d/blacklist, and other resources manage it
  # NOTE: Can remove line and readd it to keep in order (like a template)
  [
    "# #{control['title']}",
    "install #{name} /bin/false",
    "blacklist #{name}",
  ].each do |line|
    append_if_no_line control['title'] do
      path '/etc/modprobe.d/blacklist.conf'
      line line
    end
  end
end
