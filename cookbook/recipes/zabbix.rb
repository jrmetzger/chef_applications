# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: zabbix
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# https://www.zabbix.com/download?zabbix=7.2&os_distribution=red_hat_enterprise_linux&os_version=9&components=server_frontend_agent&db=pgsql&ws=apache

# Zabbix
remote_file 'zabbix-repo.rpm' do
  source 'https://repo.zabbix.com/zabbix/7.2/release/rhel/9/noarch/zabbix-release-latest-7.2.el9.noarch.rpm'
end
package 'zabbix-repo.rpm'

package %w(zabbix-server-pgsql zabbix-web-pgsql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy
           zabbix-agent)

# Postgres
package %w(postgresql-server postgresql-contrib)
execute 'postgresql-setup initdb'

service 'postgresql' do
  action :start
end

# Database
execute 'sudo -u postgres psql -c "CREATE USER zabbix WITH PASSWORD \'postgres\';"'
execute 'sudo -u postgres createdb -O zabbix zabbix'
execute 'zcat /usr/share/zabbix/sql-scripts/postgresql/server.sql.gz | sudo -u zabbix psql zabbix'

replace_or_add 'Update DBPassword' do
  path '/etc/zabbix/zabbix_server.conf'
  pattern(/"(^|# )DBPassword=.*"/)
  line 'DBPassword=postgres'
end
# StartConnectors=5

# NOTE: remove all
replace_or_add 'Update Authentication Method' do
  path '/var/lib/pgsql/data/pg_hba.conf'
  pattern(/"^local.*all.*all.*$"/)
  line 'local   all             all                                     md5'
  notifies :reload, 'service[postgresql]', :immediately
end
# host    all             all             127.0.0.1/32            md5
# host    all             all             ::1/128                 md5

# firewall-cmd --add-service=http --add-service=https --permanent
# firewall-cmd --reload

%w(zabbix-server zabbix-agent httpd php-fpm).each do |service|
  service service do
    action %i(restart enable)
  end
end

# Open Zabbix in Browser
public_ip = `curl -fsS http://169.254.169.254/latest/meta-data/public-ipv4`
file 'Script to Open Zabbix' do
  path '/tmp/zabbix_server.sh'
  content <<~EOF
    #!/bin/bash
    open http://#{public_ip}/zabbix}
  EOF
end

# sudo -u postgres psql

# DEBUG
# sudo cat /var/log/zabbix/zabbix_server.log | tail -n 20
