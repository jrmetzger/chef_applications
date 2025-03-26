# frozen_string_literal: false

default['cookbook']['harden']['controls']['sysctl'].tap do |control|
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
  control['user.max_user_namespaces'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257816: RHEL 9 must disable the use of user namespaces.'
    configuration['value'] = '0'
  end
  control['net.ipv4.conf.all.rp_filter'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257962: RHEL 9 must use reverse path filtering on all IPv4 interfaces.'
    configuration['value'] = '1'
  end
  control['net.ipv4.conf.default.accept_redirects'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257963: RHEL 9 must prevent IPv4 Internet Control Message Protocol (ICMP) redirect messages from being accepted.'
    configuration['value'] = '0'
  end
  control['net.ipv4.icmp_echo_ignore_broadcasts'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257966: RHEL 9 must not respond to Internet Control Message Protocol (ICMP) echoes sent to a broadcast address.'
    configuration['value'] = '1'
  end
  control['net.ipv4.icmp_ignore_bogus_error_responses'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257967: RHEL 9 must limit the number of bogus Internet Control Message Protocol (ICMP) response errors logs.'
    configuration['value'] = '1'
  end
  control['net.ipv4.conf.all.send_redirects'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257968: RHEL 9 must not send Internet Control Message Protocol (ICMP) redirects.'
    configuration['value'] = '0'
  end
  control['net.ipv4.conf.default.send_redirects'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257969: RHEL 9 must not allow interfaces to perform Internet Control Message Protocol (ICMP) redirects by default.'
    configuration['value'] = '0'
  end
  control['net.ipv4.conf.all.forwarding'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257970: RHEL 9 must not enable IPv4 packet forwarding unless the system is a router.'
    configuration['value'] = '0'
  end
  control['net.ipv6.conf.all.accept_ra'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257971: RHEL 9 must not accept router advertisements on all IPv6 interfaces.'
    configuration['value'] = '0'
  end
  control['net.ipv6.conf.all.accept_redirects'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257972: RHEL 9 must ignore IPv6 Internet Control Message Protocol (ICMP) redirect messages.'
    configuration['value'] = '0'
  end
  control['net.ipv6.conf.all.accept_source_route'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257973: RHEL 9 must not forward IPv6 source-routed packets.'
    configuration['value'] = '0'
  end
  control['net.ipv6.conf.all.forwarding'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257974: RHEL 9 must not enable IPv6 packet forwarding unless the system is a router.'
    configuration['value'] = '0'
  end
  control['net.ipv6.conf.default.accept_ra'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257975: RHEL 9 must not accept router advertisements on all IPv6 interfaces by default.'
    configuration['value'] = '1'
  end
  control['net.ipv6.conf.default.accept_redirects'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257976: RHEL 9 must prevent IPv6 Internet Control Message Protocol (ICMP) redirect messages from being accepted.'
    configuration['value'] = '0'
  end
  control['net.ipv6.conf.default.accept_source_route'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257977: RHEL 9 must not forward IPv6 source-routed packets by default.'
    configuration['value'] = '0'
  end
end
