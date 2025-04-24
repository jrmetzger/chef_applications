# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: sssd
#
# Copyright:: 2025, The Authors, All Rights Reserved.

package 'sssd'

# TODO
# service 'sssd' do
#  action [:enable, :start]
# end

node['cookbook']['harden']['controls']['sssd'].each do |name, control|
  next unless control['managed']

  case name
  when 'sssd_auth_ca_db'
    root_path = '~'
    remote_file "#{root_path}/unclass-certificates_pkcs7_DoD.zip" do
      source control['source']
      action :create
      notifies :run, 'execute[unzip unclass-certificates_pkcs7_DoD.zip]', :immediately # if control['source].ends_with?('zip')
    end
    package 'zip'
    execute 'unzip unclass-certificates_pkcs7_DoD.zip' do
      command "unzip #{root_path}/unclass-certificates_pkcs7_DoD.zip -d #{root_path}/unclass-certificates"
      action :nothing
    end
    link "#{root_path}/unclass-certificates/Certificates_PKCS7_v5_14_DoD/DoD_PKE_CA_chain.pem" do
      to '/etc/sssd/pki/sssd_auth_ca_db.pem'
    end
  when 'pki_authentication'
    template control['title'] do
      path '/etc/sssd/sssd.conf'
      source 'sssd.conf.erb'
    end
  end
end
