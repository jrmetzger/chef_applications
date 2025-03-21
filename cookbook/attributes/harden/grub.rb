# frozen_string_literal: false

default['cookbook']['controls']['grub'].tap do |control|
  control['vsyscall'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257792: RHEL 9 must disable virtual system calls.'
    configuration['arg'] = { 'vsyscall': 'none' }
  end
  control['page_poison'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257793: RHEL 9 must clear the page allocator to prevent use-after-free attacks.'
    configuration['arg'] = { 'page_poison': '1' }
  end
  control['slub_debug'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257794: RHEL 9 must clear SLUB/SLAB objects to prevent use-after-free attacks.'
    configuration['arg'] = { 'slub_debug': 'P' }
  end
  control['pti'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257795: RHEL 9 must enable mitigations against processor-based vulnerabilities.'
    configuration['arg'] = { 'pti': 'on' }
  end
  control['audit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257796: RHEL 9 must enable auditing of processes that start prior to the audit daemon.'
    configuration['arg'] = { 'audit': '1' }
  end
  control['audit_backlog_limit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258173: RHEL 9 must allocate an audit_backlog_limit of sufficient size to capture processes that start prior to the audit daemon.'
    configuration['arg'] = { 'audit_backlog_limit': '8192' }
  end
  control['fips'].tap do |configuration|
    configuration['managed'] = false # figure out keys first
    configuration['title'] = 'SV-258241: RHEL 9 must implement a system-wide encryption policy.'
    configuration['arg'] = { 'fips': '1' }
    configuration['mode'] = 'enable'
  end
end
