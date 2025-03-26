# frozen_string_literal: false

default['cookbook']['harden']['controls']['aide'].tap do |control|
  control['aide'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258134: RHEL 9 must have the AIDE package installed.'
  end
  control['notify'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258135: RHEL 9 must routinely check the baseline configuration for unauthorized changes and notify the system administrator when anomalies in the operation of any security functions are discovered.'
    configuration['value'] = '/usr/sbin/aide --check | /bin/mail -s "$HOSTNAME - Daily aide integrity check run" root@sysname.mil'
  end
  control['acl'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258138: RHEL 9 must be configured so that the file integrity tool verifies Access Control Lists (ACLs).'
    configuration['value'] = 'All= p+i+n+u+g+s+m+S+sha512+acl+xattrs+selinux'
  end
end
