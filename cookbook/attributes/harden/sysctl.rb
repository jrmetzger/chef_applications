# frozen_string_literal: false

default['cookbook']['controls']['sysctl'].tap do |control|
  control['kernel.dmesg_restrict'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257797: RHEL 9 must restrict access to the kernel message buffer.'
    configuration['value'] = '1'
  end
  control['kernel.perf_event_paranoid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257798: RHEL 9 must prevent kernel profiling by nonprivileged users.'
    configuration['value'] = '2'
  end
  control['kernel.kexec_load_disabled'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257799: RHEL 9 must prevent the loading of a new kernel for later execution.'
    configuration['value'] = '1'
  end
  control['kernel.kptr_restrict'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257800: RHEL 9 must restrict exposed kernel pointer addresses access.'
    configuration['value'] = '1'
  end
  control['fs.protected_hardlinks'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257801: RHEL 9 must enable kernel parameters to enforce discretionary access control on hardlinks.'
    configuration['value'] = '1'
  end
  control['fs.protected_symlinks'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257802: RHEL 9 must enable kernel parameters to enforce discretionary access control on symlinks.'
    configuration['value'] = '1'
  end
  control['kernel.core_pattern'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257803: RHEL 9 must disable the kernel.core_pattern.'
    configuration['value'] = '|/bin/false'
  end
  control['kernel.randomize_va_space'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257809: RHEL 9 must implement address space layout randomization (ASLR) to protect its memory from unauthorized code execution.'
    configuration['value'] = '2'
  end
  control['kernel.unprivileged_bpf_disabled'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257810: RHEL 9 must disable access to network bpf system call from nonprivileged processes.'
    configuration['value'] = '1'
  end
  control['kernel.yama.ptrace_scope'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257811: RHEL 9 must restrict usage of ptrace to descendant processes.'
    configuration['value'] = '1'
  end
  control['user.max_user_namespaces '].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257816: RHEL 9 must disable the use of user namespaces.'
    configuration['value'] = '0'
  end
end
