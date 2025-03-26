# frozen_string_literal: false

default['cookbook']['harden']['controls']['rsyslog'].tap do |control|
  control['rsyslog-gnutls'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258141: RHEL 9 must have the packages required for encrypting offloaded audit logs installed.'
  end
  control['monitored'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258144: All RHEL 9 remote access methods must be monitored.'
    configuration['value'] = 'auth.*;authpriv.*;daemon.* /var/log/secure'
  end
end
