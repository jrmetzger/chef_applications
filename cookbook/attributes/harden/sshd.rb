# frozen_string_literal: false

default['cookbook']['controls']['sshd'].tap do |control|
  control['Banner'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257981: RHEL 9 must display the Standard Mandatory DOD Notice and Consent Banner before granting local or remote access to the system via a SSH logon.'
    configuration['value'] = '/etc/issue'
  end
  control['LogLevel'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = ' SV-257982: RHEL 9 must log SSH connection attempts and failures to the server.'
    configuration['value'] = 'VERBOSE'
  end
  control['PubkeyAuthentication'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257983: RHEL 9 SSHD must accept public key authentication.'
    configuration['value'] = 'yes'
  end
  control['PermitEmptyPasswords'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257984: RHEL 9 SSHD must not allow blank passwords.'
    configuration['value'] = 'no'
  end
  control['PermitRootLogin'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257985: RHEL 9 must not permit direct logons to the root account using remote access via SSH'
    configuration['value'] = 'no' # Unless login as root. Fine for vagrant
  end
  control['UsePAM'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257986: RHEL 9 must enable the Pluggable Authentication Module (PAM) interface for SSHD'
    configuration['value'] = 'yes'
  end
end
