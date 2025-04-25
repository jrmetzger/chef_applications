# frozen_string_literal: false

default['cookbook']['harden']['controls']['aide'].tap do |control|
  control['package'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258134: RHEL 9 must have the AIDE package installed.'
  end
  control['notify'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-258135: RHEL 9 must routinely check the baseline configuration for unauthorized changes and notify the system administrator when anomalies in the operation of any security functions are discovered.'
    configuration['path'] = '/etc/cron.daily/aide'
    configuration['values'] = [
      '/usr/sbin/aide --check | /bin/mail -s "$HOSTNAME - Daily aide integrity check run" root@sysname.mil',
    ]
  end
  control['sha512'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-258136: RHEL 9 must use a file integrity tool that is configured to use FIPS 140-3-approved cryptographic hashes for validating file contents and directories.'
    configuration['values'] = [
      'All=p+i+n+u+g+s+m+S+sha512+acl+xattrs+selinux',
    ]
  end
  control['cryptographic'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-258137: RHEL 9 must use cryptographic mechanisms to protect the integrity of audit tools.'
    configuration['values'] = [
      '/usr/sbin/auditctl p+i+n+u+g+s+b+acl+xattrs+sha512',
      '/usr/sbin/auditd p+i+n+u+g+s+b+acl+xattrs+sha512',
      '/usr/sbin/ausearch p+i+n+u+g+s+b+acl+xattrs+sha512',
      '/usr/sbin/aureport p+i+n+u+g+s+b+acl+xattrs+sha512',
      '/usr/sbin/autrace p+i+n+u+g+s+b+acl+xattrs+sha512',
      '/usr/sbin/augenrules p+i+n+u+g+s+b+acl+xattrs+sha512',
    ]
  end
  control['acl'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-258138: RHEL 9 must be configured so that the file integrity tool verifies Access Control Lists (ACLs).'
  end
  control['xattrs'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-258139: RHEL 9 must be configured so that the file integrity tool verifies extended attributes.'
    # configuration['path'] = '/etc/aide.conf'
    # configuration['values'] = [
    #  'All=p+i+n+u+g+s+m+S+sha512+acl+xattrs+selinux',
    #  ]
  end
end
