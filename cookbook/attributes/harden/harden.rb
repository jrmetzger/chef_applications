default['cookbook']['harden']['control_groups'].tap do |control_groups|
  control_groups['aide'] = true
  control_groups['audit'] = true
  control_groups['grub'] = true
  control_groups['logindefs'] = true
  control_groups['modprobe'] = true
  control_groups['mount'] = false
  control_groups['packages'] = true
  control_groups['rsyslog'] = true
  control_groups['security'] = true
  control_groups['sshd'] = true
  control_groups['sysctl'] = true
  control_groups['systemd'] = true
end
