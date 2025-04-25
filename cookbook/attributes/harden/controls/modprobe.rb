# frozen_string_literal: false

default['cookbook']['harden']['controls']['modprobe'].tap do |control|
  control['atm'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-257804: RHEL 9 must be configured to disable the Asynchronous Transfer Mode kernel module.'
  end
  control['can'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-257805: RHEL 9 must be configured to disable the Controller Area Network kernel module.'
  end
  control['firewire_core'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257806: RHEL 9 must be configured to disable the FireWire kernel module.'
  end
  control['sctp'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-257807: RHEL 9 must disable the Stream Control Transmission Protocol (SCTP) kernel module.'
  end
  control['tipc'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-257808: RHEL 9 must disable the Transparent Inter Process Communication (TIPC) kernel module.'
  end
  control['bluetooth'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258034: RHEL 9 must be configured to disable USB mass storage.'
  end
  control['bluetooth'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = ' SV-258039: RHEL 9 Bluetooth must be disabled.'
  end
end
