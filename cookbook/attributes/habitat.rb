# frozen_string_literal: false

default['cookbook']['habitat']['apps'].tap do |apps|
  apps['chef-infra-client'].tap do |client|
    client['managed'] = false
    client['group'] = 'chef'
    client['config'] = {}
    client['user_toml'] = {}
  end
  apps['postgresql15'].tap do |client|
    client['managed'] = false
    client['group'] = 'core'
    client['config'] = {}
    client['user_toml'] = {}
  end
end
