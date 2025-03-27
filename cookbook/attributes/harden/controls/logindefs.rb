# frozen_string_literal: false

default['cookbook']['harden']['controls']['logindefs'].tap do |control|
  control['SHA_CRYPT_MAX_ROUNDS'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258119: RHEL 9 shadow password suite must be configured to use a sufficient number of hashing rounds.'
    configuration['value'] = '5000'
  end
  control['PASS_MAX_DAYS'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258041: RHEL 9 user account passwords for new users or password changes must have a 60-day maximum password lifetime restriction in /etc/login.defs.'
    configuration['value'] = '60'
  end
  control['FAIL_DELAY'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258071: RHEL 9 must enforce a delay of at least four seconds between logon prompts following a failed logon attempt.'
    configuration['value'] = '4'
  end
  control['UMASK'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258074: RHEL 9 must define default permissions for all authenticated users in such a way that the user can only read and modify their own files.'
    configuration['value'] = '077'
  end
  control['PASS_MIN_DAYS'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258104: RHEL 9 passwords for new users or password changes must have a 24 hours minimum password lifetime restriction in /etc/login.defs.'
    configuration['value'] = '1'
  end
  control['PASS_MIN_LEN'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258108: RHEL 9 passwords for new users must have a minimum of 15 characters.'
    configuration['value'] = '15'
  end
end
