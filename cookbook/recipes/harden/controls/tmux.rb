# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: tmux
#
# Copyright:: 2025, The Authors, All Rights Reserved.

package 'tmux'

node['cookbook']['harden']['controls']['tmux'].each do |_name, control|
  next unless control['managed']
end
