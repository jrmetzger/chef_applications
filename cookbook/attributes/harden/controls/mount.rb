# frozen_string_literal: false

# TODO: device and fstype merge?
default['cookbook']['harden']['controls']['mount'].tap do |control|
  control['/dev/shm-nodev'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257863: RHEL 9 must mount /dev/shm with the nodev option.'
  end
  control['/dev/shm-noexec'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257864: RHEL 9 must mount /dev/shm with the noexec option.'
  end
  control['/dev/shm-nosuid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257865: RHEL 9 must mount /dev/shm with the nosuid option.'
  end
  control['/tmp-nodev'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257866: RHEL 9 must mount /tmp with the nodev option.'
  end
  control['/tmp-noexec'].tap do |configuration|
    configuration['managed'] = false # mess up test kitchen
    configuration['title'] = 'SV-257867: RHEL 9 must mount /tmp with the noexec option.'
  end
  control['/tmp-suid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257868: RHEL 9 must mount /tmp with the nosuid option.'
  end
end
