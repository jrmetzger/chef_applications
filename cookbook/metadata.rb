# frozen_string_literal: true

name 'cookbook'
maintainer 'Jon Metzger'
maintainer_email 'n/a'
license 'All Rights Reserved'
description 'Installs/Configures applications'
version '0.1.0'
chef_version '>= 16.0'

# https://supermarket.chef.io/cookbooks/line
depends 'line', '~> 4.5'
depends 'docker', '~> 11.9'
depends 'limits', '~> 2.3'
depends 'firewall', '~> 7.0'
depends 'lvm', '~> 6.2'
depends 'selinux', '~> 6.2'
