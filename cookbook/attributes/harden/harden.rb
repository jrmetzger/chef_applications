
default['cookbook']['harden']['standard'] = 'stig'
# default['cookbook']['harden']['override_control_groups'] = %w(
#  packages
# )

default['cookbook']['harden']['mount_settings'].tap do |mount_settings|
  mount_settings['pv_name'] = '/dev/mapper'
  mount_settings['lv_name'] = `vgs -o NAME --no-heading`.strip
  mount_settings['lv_size'] = '1G'
end

default['cookbook']['harden']['control_groups'].tap do |control_groups|
  control_groups['aide'] = true
  control_groups['audit'] = true
  control_groups['grub'] = true
  control_groups['logindefs'] = true
  control_groups['modprobe'] = true
  control_groups['mount'] = true
  control_groups['packages'] = true
  control_groups['pamd'] = true
  control_groups['rsyslog'] = true
  control_groups['security'] = true
  control_groups['selinux'] = true
  control_groups['sshd'] = true
  control_groups['sysctl'] = true
  control_groups['systemd'] = true
  control_groups['tmux'] = true
  control_groups['usbguard'] = true
end
