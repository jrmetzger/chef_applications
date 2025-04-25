# frozen_string_literal: false

# TODO: device and fstype merge?
default['cookbook']['harden']['controls']['mount'].tap do |control|
  control['autofs'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-257850: RHEL 9 must prevent device files from being interpreted on file systems that contain user home directories.'
  end
  control['/home-nodev'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] =
      'SV-257850: RHEL 9 must prevent device files from being interpreted on file systems that contain user home directories.'
  end
  control['/home-nosuid'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] =
      'SV-257851: RHEL 9 must prevent files with the setuid and setgid bit set from being executed on file systems that contain user home directories.'
  end
  control['/home-noexec'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] =
      'SV-257852: RHEL 9 must prevent code from being executed on file systems that contain user home directories.'
  end
  control['/boot-suid'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] =
      'SV-257861: RHEL 9 must prevent files with the setuid and setgid bit set from being executed on the /boot directory.'
  end
  control['/boot/efi-suid'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] =
      'SV-257862: RHEL 9 must prevent files with the setuid and setgid bit set from being executed on the /boot/efi directory.'
  end
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
  control['/var-nodev'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257869: RHEL 9 must mount /var with the nodev option.'
  end
  control['/var/log-nodev'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257870: RHEL 9 must mount /var/log with the nodev option.'
  end
  control['/var/log-noexec'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257871: RHEL 9 must mount /var/log with the noexec option.'
  end
  control['/var/log-nosuid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257872: RHEL 9 must mount /var/log with the nosuid option.'
  end
  control['/var/log/audit-nodev'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257873: RHEL 9 must mount /var/log/audit with the nodev option.'
  end
  control['/var/log/audit-noexec'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257874: RHEL 9 must mount /var/log/audit with the noexec option.'
  end
  control['/var/log/audit-nosuid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257875: RHEL 9 must mount /var/log/audit with the nosuid option.'
  end
  control['/var/tmp-nodev'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257876: RHEL 9 must mount /var/log/audit with the nodev option.'
  end
  control['/var/tmp-noexec'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257877: RHEL 9 must mount /var/log/audit with the noexec option.'
  end
  control['/var/tmp-nosuid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257878: RHEL 9 must mount /var/log/audit with the nosuid option.'
  end
end
