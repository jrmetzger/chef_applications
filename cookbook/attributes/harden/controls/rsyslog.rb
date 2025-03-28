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
  control['$ActionSendStreamDriverAuthMod'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258146: RHEL 9 must authenticate the remote logging server for offloading audit logs via rsyslog.'
    configuration['value'] = '1'
  end
  control['$ActionSendStreamDriverMode'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258147: RHEL 9 must encrypt the transfer of audit records offloaded onto a different system or media from the system being audited via rsyslog.'
  end
  control['$DefaultNetstreamDriver'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258148: RHEL 9 must encrypt via the gtls driver the transfer of audit records offloaded onto a different system or media from the system being audited via rsyslog.'
    configuration['value'] = '1'
  end
  control['Forward_Audit_Records'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258149: RHEL 9 must be configured to forward audit records via TCP to a different system or media from the system being audited via rsyslog.'
    configuration['value'] = 'TCP *.* @@localhost'
  end
end
