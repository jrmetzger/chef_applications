# frozen_string_literal: false

supported_arches = %w(32) # 64)
default['cookbook']['controls']['audit'].tap do |control|
  control['active'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258145: RHEL 9 must be configured to offload audit records onto a different system from the system being audited via syslog.'
    configuration['path'] = '/etc/audit/plugins.d/syslog.conf'
    configuration['config'] = { 'active': 'yes' }
  end
  control['disk_error_action'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258153: RHEL 9 audit system must take appropriate action when an error writing to the audit storage volume occurs.'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'disk_error_action': 'SINGLE' }
  end
  control['disk_full_action'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = ' SV-258154: RHEL 9 audit system must take appropriate action when the audit storage volume is full.'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'disk_full_action': 'SINGLE' }
  end
  control['space_left_action'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258157: RHEL 9 must notify the system administrator (SA) and information system security officer (ISSO) (at a minimum) when allocated audit record storage volume 75 percent utilization.'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'space_left_action': 'email' }
  end
  control['admin_space_left'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258158: RHEL 9 must take action when allocated audit record storage volume reaches 95 percent of the audit record storage capacity.'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'admin_space_left': '5%' }
  end
  control['admin_space_left_action'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258159: RHEL 9 must take action when allocated audit record storage volume reaches 95 percent of the repository maximum audit record storage capacity.'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'admin_space_left_action': 'SINGLE' }
  end
  control['name_format'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258161: RHEL 9 must label all offloaded audit logs before sending them to the central log server'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'name_format': 'hostname' }
  end
  control['freq'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258168: RHEL 9 must periodically flush audit records to disk to prevent the loss of audit records.'
    configuration['path'] = '/etc/audit/auditd.conf'
    configuration['config'] = { 'freq': '100' }
  end
  control['audispd-plugins'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258175: RHEL 9 audispd-plugins package must be installed.'
    configuration['package'] = 'audispd-plugins'
  end
  control['execve'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258176: RHEL 9 must audit uses of the "execve" system call.'
    configuration['rules'] = []
    supported_arches.each do |arch|
      %w(uid gid).each do |typ|
        configuration['rules'] << "-a always,exit -F arch=b#{arch} -S execve -C #{typ}!=e#{typ} -F e#{typ}=0 -k execpriv"
      end
    end
  end
  control['chmod'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258177: RHEL 9 must audit all uses of the chmod, fchmod, and fchmodat system calls.'
    configuration['rules'] = []
    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -k perm_mod"
    end
  end
  control['chown'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258178: RHEL 9 must audit all uses of the chown, fchown, fchownat, and lchown system calls.'
    configuration['rules'] = []
    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S chown,fchown,fchownat,lchown -F auid>=1000 -F auid!=unset -k perm_mod"
    end
  end
  control['xattr'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258179: RHEL 9 must audit all uses of the setxattr, fsetxattr, lsetxattr, removexattr, fremovexattr, and lremovexattr system calls.'
    configuration['rules'] = []
    supported_arches.each do |_arch|
      ['-F auid>=1000 -F auid!=unset', 'F auid=0'].each do |auid|
        # configuration['rules'] << "-a always,exit -F arch=b#{arch} -S setxattr,fsetxattr,lsetxattr,removexattr,fremovexattr,lremovexattr #{auid} -k perm_mod"
      end
    end
  end
  control['umount'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258180: RHEL 9 must audit all uses of umount system calls.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/umount -F perm=x -F auid>=1000 -F auid!=unset -k privileged-mount'
  end
  control['chacl'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258181: RHEL 9 must audit all uses of the chacl command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_mod'
  end
  control['setfacl'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258182: RHEL 9 must audit all uses of the setfacl command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_mod'
  end
  control['chcon'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258183: RHEL 9 must audit all uses of the chcon command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=unset -k perm_mod'
  end
  control['semanage'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258184: RHEL 9 must audit all uses of the semanage command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/semanage -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['setfiles'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258185: RHEL 9 must audit all uses of the setfiles command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/setfiles -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['setsebool'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258186: RHEL 9 must audit all uses of the setsebool command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/setsebool -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged-unix-update'
  end
  control['files'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258187: RHEL 9 must audit all uses of the rename, unlink, rmdir, renameat, and unlinkat system calls.'
    configuration['rules'] = []

    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S rename,unlink,rmdir,renameat,unlinkat -F auid>=1000 -F auid!=unset -k delete"
    end
  end
  control['file'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258188: RHEL 9 must audit all uses of the truncate, ftruncate, creat, open, openat, and open_by_handle_at system calls.'
    configuration['rules'] = []

    supported_arches.each do |arch|
      %w(PERM ACCES).each do |param|
        configuration['rules'] << "-a always,exit -F arch=b#{arch} -S truncate,ftruncate,creat,open,openat,open_by_handle_at -F exit=-E#{param} -F auid>=1000 -F auid!=unset -k perm_access"
      end
    end
  end
  control['delete_module'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'SV-258189: RHEL 9 must audit all uses of the delete_module system call.'
    configuration['rules'] = []

    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S delete_module -F auid>=1000 -F auid!=unset -k module_chng"
    end
  end
  control['init_module'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258190: RHEL 9 must audit all uses of the init_module and finit_module system calls.'
    configuration['rules'] = []

    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S init_module,finit_module -F auid>=1000 -F auid!=unset -k module_chng"
    end
  end
  control['chage'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258191: RHEL 9 must audit all uses of the chage command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/chage -F perm=x -F auid>=1000 -F auid!=unset -k privileged-chage'
  end
  control['chsh'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258192: RHEL 9 must audit all uses of the chsh command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/chsh -F perm=x -F auid>=1000 -F auid!=unset -k priv_cmd'
  end
  control['crontab'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258193: RHEL 9 must audit all uses of the crontab command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/crontab -F perm=x -F auid>=1000 -F auid!=unset -k privileged-crontab'
  end
  control['gpasswd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258194: RHEL 9 must audit all uses of the gpasswd command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/gpasswd -F perm=x -F auid>=1000 -F auid!=unset -k privileged-gpasswd'
  end
  control['kmod'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258195: RHEL 9 must audit all uses of the kmod command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/kmod -F perm=x -F auid>=1000 -F auid!=unset -k modules'
  end
  control['newgrp'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258196: RHEL 9 must audit all uses of the newgrp command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/newgrp -F perm=x -F auid>=1000 -F auid!=unset -k priv_cmd'
  end
  control['pam_timestamp_check'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258197: RHEL 9 must audit all uses of the pam_timestamp_check command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/pam_timestamp_check -F perm=x -F auid>=1000 -F auid!=unset -k privileged-pam_timestamp_check'
  end
  control['passwd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258198: RHEL 9 must audit all uses of the passwd command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/passwd -F perm=x -F auid>=1000 -F auid!=unset -k privileged-passwd'
  end
  control['postdrop'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258199: RHEL 9 must audit all uses of the postdrop command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/postdrop -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['postqueue'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258200: RHEL 9 must audit all uses of the postqueue command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/postqueue -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['ssh-agent'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258201: RHEL 9 must audit all uses of the ssh-agent command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/ssh-agent -F perm=x -F auid>=1000 -F auid!=unset -k privileged-ssh'
  end
  control['ssh-keysign'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258202: RHEL 9 must audit all uses of the ssh-keysign command.'
    configuration['rule'] = '-a always,exit -F path=/usr/libexec/openssh/ssh-keysign -F perm=x -F auid>=1000 -F auid!=unset -k privileged-ssh'
  end
  control['su'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258203: RHEL 9 must audit all uses of the su command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/su -F perm=x -F auid>=1000 -F auid!=unset -k privileged-priv_change'
  end
  control['sudo'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258204: RHEL 9 must audit all uses of the sudo command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/sudo -F perm=x -F auid>=1000 -F auid!=unset -k priv_cmd'
  end
  control['sudoedit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258205: RHEL 9 must audit all uses of the sudoedit command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/sudoedit -F perm=x -F auid>=1000 -F auid!=unset -k priv_cmd'
  end
  control['unix_chkpwd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258206: RHEL 9 must audit all uses of the unix_chkpwd command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/unix_chkpwd -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['unix_update'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258207: RHEL 9 must audit all uses of the unix_update command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/unix_update -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['userhelper'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258208: RHEL 9 must audit all uses of the userhelper command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/userhelper -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
  end
  control['usermod'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258209: RHEL 9 must audit all uses of the usermod command.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=unset -k privileged-usermod'
  end
  control['mount'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258210: RHEL 9 must audit all uses of the mount command.'
    configuration['rule'] = '-a always,exit -F path=/usr/bin/mount -F perm=x -F auid>=1000 -F auid!=unset -k privileged-mount'
  end
  control['init'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258211: Successful/unsuccessful uses of the init command in RHEL 9 must generate an audit record.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/init -F perm=x -F auid>=1000 -F auid!=unset -k privileged-init'
  end
  control['poweroff'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258212: Successful/unsuccessful uses of the poweroff command in RHEL 9 must generate an audit record.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/poweroff -F perm=x -F auid>=1000 -F auid!=unset -k privileged-poweroff'
  end
  control['reboot'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258213: Successful/unsuccessful uses of the reboot command in RHEL 9 must generate an audit record.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/reboot -F perm=x -F auid>=1000 -F auid!=unset -k privileged-reboot'
  end
  control['shutdown'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258214: Successful/unsuccessful uses of the shutdown command in RHEL 9 must generate an audit record.'
    configuration['rule'] = '-a always,exit -F path=/usr/sbin/shutdown -F perm=x -F auid>=1000 -F auid!=unset -k privileged-shutdown'
  end
  control['umount'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258215: Successful/unsuccessful uses of the umount system call in RHEL 9 must generate an audit record.'
    configuration['rules'] = []
    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S umount -F auid>=1000 -F auid!=unset -k privileged-umount"
    end
  end
  control['umount2'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258216: Successful/unsuccessful uses of the umount2 system call in RHEL 9 must generate an audit record.'
    configuration['rules'] = []
    supported_arches.each do |arch|
      configuration['rules'] << "-a always,exit -F arch=b#{arch} -S umount2 -F auid>=1000 -F auid!=unset -k perm_mod"
    end
  end
  control['sudoers'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258217: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/sudoers.'
    configuration['rule'] = '-w /etc/sudoers -p wa -k identity'
  end
  control['sudoers.d'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258218: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/sudoers.d/ directory.'
    configuration['rule'] = '-w /etc/sudoers.d/ -p wa -k identity'
  end
  control['group'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258219: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/group.'
    configuration['rule'] = '-w /etc/group -p wa -k identity'
  end
  control['gshadow'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258220: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/gshadow.'
    configuration['rule'] = '-w /etc/gshadow -p wa -k identity'
  end
  control['opasswd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258221: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/opasswd.'
    configuration['rule'] = '-w /etc/security/opasswd -p wa -k identity'
  end
  control['passwd'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258222: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/passwd.'
    configuration['rule'] = '-w /etc/passwd -p wa -k identity'
  end
  control['shadow'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258223: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/shadow.'
    configuration['rule'] = '-w /etc/shadow -p wa -k identity'
  end
  control['faillock'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258224: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /var/log/faillock.'
    configuration['rule'] = '-w /var/log/faillock -p wa -k logins'
  end
  control['lastlog'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258225: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /var/log/lastlog.'
    configuration['rule'] = '-w /var/log/lastlog -p wa -k logins'
  end
  control['tallylog'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'SV-258226: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /var/log/tallylog.'
    configuration['rule'] = '-w /var/log/tallylog -p wa -k logins'
  end
  control['critical'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258227: RHEL 9 must take appropriate action when a critical audit processing failure occurs.'
    configuration['rule'] = '-f 2'
  end
  control['loginuid'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258228: RHEL 9 audit system must protect logon UIDs from unauthorized change.'
    configuration['rule'] = '--loginuid-immutable'
  end
  control['unauthorized'].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'SV-258229: RHEL 9 audit system must protect auditing rules from unauthorized change.'
    configuration['rule'] = '-e 2'
  end
end
