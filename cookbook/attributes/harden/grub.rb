# frozen_string_literal: false

default['cookbook']['controls']['grub'].tap do |control|
  control['vsyscall'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257792: RHEL 9 must disable virtual system calls.'
    configuration['arg'].tap do |arg|
      arg['vsyscall'] = 'none'
    end
  end
  control['page_poison'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257793: RHEL 9 must clear the page allocator to prevent use-after-free attacks.'
    configuration['arg'].tap do |arg|
      arg['page_poison'] = '1'
    end
  end
  control['slub_debug'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257794: RHEL 9 must clear SLUB/SLAB objects to prevent use-after-free attacks.'
    configuration['arg'].tap do |arg|
      arg['slub_debug'] = 'P'
    end
  end
  control['pti'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257795: RHEL 9 must enable mitigations against processor-based vulnerabilities.'
    configuration['arg'].tap do |arg|
      arg['pti'] = 'on'
    end
  end
  control['audit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257796: RHEL 9 must enable auditing of processes that start prior to the audit daemon.'
    configuration['arg'].tap do |arg|
      arg['audit'] = '1'
    end
  end
  control['audit_backlog_limit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258173: RHEL 9 must allocate an audit_backlog_limit of sufficient size to capture processes that start prior to the audit daemon.'
    configuration['arg'].tap do |arg|
      arg['audit_backlog_limit'] = '8192'
    end
  end
  control['fips'].tap do |configuration|
    configuration['managed'] = false # figure out keys first
    configuration['title'] = 'SV-258241: RHEL 9 must implement a system-wide encryption policy.'
    configuration['arg'].tap do |arg|
      arg['fips'] = '1'
    end
    configuration['mode'] = 'enable'
  end
end
