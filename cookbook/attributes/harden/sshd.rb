# frozen_string_literal: false

default['cookbook']['controls']['sshd'].tap do |control|
  control['CLI_Login_Banner'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257779: RHEL 9 must display the Standard Mandatory DOD Notice and Consent Banner before granting local or remote access to the system via a command line user logon'
    configuration['content'] = "You are accessing a U.S. Government (USG) Information System (IS) that is provided for USG-authorized use only.

By using this IS (which includes any device attached to this IS), you consent to the following conditions:

-The USG routinely intercepts and monitors communications on this IS for purposes including, but not limited to, penetration testing, COMSEC monitoring, network operations and defense, personnel misconduct (PM), law enforcement (LE), and counterintelligence (CI) investigations.

-At any time, the USG may inspect and seize data stored on this IS.

-Communications using, or data stored on, this IS are not private, are subject to routine monitoring, interception, and search, and may be disclosed or used for any USG-authorized purpose.

-This IS includes security measures (e.g., authentication and access controls) to protect USG interests -- not for your personal benefit or privacy.

-Notwithstanding the above, using this IS does not constitute consent to PM, LE or CI investigative searching or monitoring of the content of privileged communications, or work product, related to personal representation or services by attorneys, psychotherapists, or clergy, and their assistants. Such communications and work product are private and confidential. See User Agreement for details."
  end
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
  control['HostBasedAuthentication'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257992: RHEL 9 must not allow a noncertificate trusted host SSH logon to the system.'
    configuration['value'] = 'no'
  end
  control['PermitUserEnvironment'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257993: RHEL 9 must not allow users to override SSH environment variables.'
    configuration['value'] = 'no'
  end
  control['RekeyLimit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257994: RHEL 9 must force a frequent session key renegotiation for SSH connections to the server.'
    configuration['value'] = '1G 1h'
  end
  control['ClientAliveCountMax'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257995: RHEL 9 must be configured so that all network connections associated with SSH traffic terminate after becoming unresponsive.'
    configuration['value'] = '1'
  end
  control['UsePAM'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257986: RHEL 9 must enable the Pluggable Authentication Module (PAM) interface for SSHD'
    configuration['value'] = 'yes'
  end
  control['Compression'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258002: RHEL 9 SSH daemon must not allow compression or must only allow compression after successful authentication.'
    configuration['value'] = 'delayed' # Default, or no
  end
  control['GSSAPIAuthentication'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258003: RHEL 9 SSH daemon must not allow GSSAPI authentication.'
    configuration['value'] = 'no' # Unless using Kerberos
  end
  control['KerberosAuthentication'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258004: RHEL 9 SSH daemon must not allow Kerberos authentication.'
    configuration['value'] = 'no' # Unless using Kerberos
  end
  control['IgnoreRhosts'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258005: RHEL 9 SSH daemon must not allow rhosts authentication.'
    configuration['value'] = 'yes'
  end
  control['IgnoreUserKnownHosts'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258006: RHEL 9 SSH daemon must not allow known hosts authentication.'
    configuration['value'] = 'yes'
  end
  control['X11Forwarding'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258007: RHEL 9 SSH daemon must disable remote X connections for interactive users.'
    configuration['value'] = 'no'
  end
  control['StrictModes'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258008: RHEL 9 SSH daemon must perform strict mode checking of home directory configuration files.'
    configuration['value'] = 'yes'
  end
  control['PrintLastLog'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258009: RHEL 9 SSH daemon must display the date and time of the last successful account logon upon an SSH logon.'
    configuration['value'] = 'yes'
  end
  control['UsePrivilegeSeparation'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258010: RHEL 9 SSH daemon must be configured to use privilege separation.'
    configuration['value'] = 'yes' # DEPRECATED, new entry. 'sandbox' works too
  end
  control['X11UseLocalhost'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258011: RHEL 9 SSH daemon must prevent remote hosts from connecting to the proxy display.'
    configuration['value'] = 'yes'
  end
end
