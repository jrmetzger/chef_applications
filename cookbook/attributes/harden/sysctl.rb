# frozen_string_literal: false

default['cookbook']['controls']['sysctl'].tap do |control|
  control['kernel.dmesg_restrict'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257797: RHEL 9 must restrict access to the kernel message buffer.'
    configuration['config'] = { 'kernel.dmesg_restrict': '1' }
  end
  control['kernel.perf_event_paranoid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257798: RHEL 9 must prevent kernel profiling by nonprivileged users.'
    configuration['config'] = { 'kernel.perf_event_paranoid': '2' }
  end
  control['kernel.kexec_load_disabled'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257799: RHEL 9 must prevent the loading of a new kernel for later execution.'
    configuration['config'] = { 'kernel.kexec_load_disabled': '1' }
  end
  control['kernel.kptr_restrict'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257800: RHEL 9 must restrict exposed kernel pointer addresses access.'
    configuration['config'] = { 'kernel.kptr_restrict': '1' }
  end
  control['fs.protected_hardlinks'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257801: RHEL 9 must enable kernel parameters to enforce discretionary access control on hardlinks.'
    configuration['config'] = { 'fs.protected_hardlinks': '1' }
  end
  control['fs.protected_symlinks'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257802: RHEL 9 must enable kernel parameters to enforce discretionary access control on symlinks.'
    configuration['config'] = { 'fs.protected_symlinks': '1' }
  end
  control['kernel.core_pattern'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257803: RHEL 9 must disable the kernel.core_pattern.'
    configuration['config'] = { 'kernel.core_pattern': '1' }
  end
end
