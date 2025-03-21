# frozen_string_literal: false

default['cookbook']['controls']['security'].tap do |control|
  control['maxlogins'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258069: RHEL 9 must limit the number of concurrent sessions to ten for all accounts and/or account types.'
    configuration['value'] = '10'
  end
  control['audit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258070: RHEL 9 must log username information when unsuccessful logon attempts occur.'
    configuration['value'] = ''
  end
  control['enforce_for_root'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258101: RHEL 9 must enforce password complexity rules for the root account.'
    configuration['value'] = ''
  end
  control['lcredit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258102: RHEL 9 must enforce password complexity by requiring that at least one lowercase character be used.'
    configuration['value'] = '-1'
  end
  control['dcredit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258103: RHEL 9 must enforce password complexity by requiring that at least one numeric character be used.'
    configuration['value'] = '-1'
  end
  control['minlen'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258107: RHEL 9 passwords must be created with a minimum of 15 characters.'
    configuration['value'] = '15'
  end
  control['minlen'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258109: RHEL 9 must enforce password complexity by requiring that at least one special character be used.'
    configuration['value'] = '15'
  end
  control['dictcheck'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258110: RHEL 9 must prevent the use of dictionary words for passwords.'
    configuration['value'] = '1'
  end
  control['ucredit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258111: RHEL 9 must enforce password complexity by requiring that at least one uppercase character be used.'
    configuration['value'] = '-1'
  end
  control['difok'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258112: RHEL 9 must require the change of at least eight characters when passwords are changed.'
    configuration['value'] = '8'
  end
  control['maxclassrepeat'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258113: RHEL 9 must require the maximum number of repeating characters of the same character class be limited to four when passwords are changed.'
    configuration['value'] = '4'
  end
  control['maxrepeat'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258114: RHEL 9 must require the maximum number of repeating characters be limited to three when passwords are changed.'
    configuration['value'] = '3'
  end
  control['minclass'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258115: RHEL 9 must require the change of at least four character classes when passwords are changed.'
    configuration['value'] = '4'
  end
end
