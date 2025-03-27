# frozen_string_literal: false

default['cookbook']['harden']['controls']['packages'].tap do |control|
  control['nfs-utils'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257828: RHEL 9 must not have the nfs-utils package installed.'
  end
  control['gssproxy'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257832: RHEL 9 must not have the gssproxy package installed.'
  end
  control['tuned'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257834: RHEL 9 must not have the tuned package installed.'
  end
  control['rng-tools'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257841: RHEL 9 must have the rng-tools package installed.'
  end
  control['main.localpkg_gpgcheck'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257821: RHEL 9 must check the GPG signature of locally installed software packages before installation.'
    configuration['value'] = 'yes'
  end
  control['s-nail'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257842: RHEL 9 must have the s-nail package installed.'
  end
  control['libreswan'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257954: RHEL 9 libreswan package must be installed.'
  end
  control['EndpointSecurity'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'SV-257780: RHEL 9 must implement the Endpoint Security for Linux Threat Prevention tool.'
    configuration['package'] = 'clamav'
    configuration['service'] = 'freshclam'
  end
  control['usbguard'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258035: RHEL 9 must have the USBGuard package installed.'
  end
  control['fapolicyd'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'Linux fapolicy module must be installed.'
  end
end
