# frozen_string_literal: false

default['cookbook']['harden']['controls']['grub'].tap do |control|
  control['boot_loader_superuser_password'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257787: RHEL 9 must require a boot loader superuser password.'
    configuration['value'] = 'grub.pbkdf2.sha512.10000.C4E08AC72FBFF7E837FD267BFAD7AEB3D42DDC
2C99F2A94DD5E2E75C2DC331B719FE55D9411745F82D1B6CFD9E927D61925F9BBDD1CFAA0080E0
916F7AB46E0D.1302284FCCC52CD73BA3671C6C12C26FF50BA873293B24EE2A96EE3B57963E6D7
0C83964B473EC8F93B07FE749AA6710269E904A9B08A6BBACB00A2D242AD828'
  end
  control['boot_loader_superusers_name'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257789: RHEL 9 must require a unique superusers name upon booting into single-user and maintenance modes.'
    configuration['value'] = 'superuser'
  end

  control['vsyscall'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257792: RHEL 9 must disable virtual system calls.'
    configuration['value'] = 'none'
  end
  control['page_poison'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257793: RHEL 9 must clear the page allocator to prevent use-after-free attacks.'
    configuration['value'] = '1'
  end
  control['slub_debug'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257794: RHEL 9 must clear SLUB/SLAB objects to prevent use-after-free attacks.'
    configuration['value'] = 'P'
  end
  control['pti'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257795: RHEL 9 must enable mitigations against processor-based vulnerabilities.'
    configuration['value'] = 'on'
  end
  control['audit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257796: RHEL 9 must enable auditing of processes that start prior to the audit daemon.'
    configuration['value'] = '1'
  end
  control['audit_backlog_limit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258173: RHEL 9 must allocate an audit_backlog_limit of sufficient size to capture processes that start prior to the audit daemon.'
    configuration['value'] = '8192'
  end
  control['fips'].tap do |configuration|
    configuration['managed'] = false # figure out keys first
    configuration['title'] = 'SV-258241: RHEL 9 must implement a system-wide encryption policy.'
    configuration['value'] = '1'
    configuration['mode'] = 'enable'
  end
end
