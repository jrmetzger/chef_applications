# frozen_string_literal: false

default['cookbook']['harden']['controls']['sssd'].tap do |control|
  control['CLI_Login_Banner'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257779: RHEL 9 must display the Standard Mandatory DOD Notice and Consent Banner before granting local or remote access to the system via a command line user logon'
    configuration['content'] = ''
  end
end
