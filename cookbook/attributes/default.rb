# frozen_string_literal: false

default['cookbook']['controls'].tap do |controls|
  supported_arches = %w(32) # %w(32 64)
  controls['audit'].tap do |audit|
    audit['audispd-plugins'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258175: RHEL 9 audispd-plugins package must be installed.'
      configuration['package'] = 'audispd-plugins'
    end
    audit['execve'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258176: RHEL 9 must audit uses of the "execve" system call.'
      configuration['rules'] = [
        '-a always,exit -F arch=b32 -S execve -k execve-audit',
        '-a always,exit -F arch=b64 -S execve -k execve-audit',
      ]
    end
    audit['chmod'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258177: RHEL 9 must audit all uses of the chmod, fchmod, and fchmodat system calls.'
      configuration['rules'] = [
        '-a always,exit -F arch=b32 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -k perm_mod',
        # '-a always,exit -F arch=b64 -S chmod,fchmod,fchmodat -F auid>=1000 -F auid!=unset -k perm_mod',

      ]
    end
    audit['chown'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258178: RHEL 9 must audit all uses of the chown, fchown, fchownat, and lchown system calls.'
      configuration['rules'] = [
        '-a always,exit -F arch=b32 -S chown,fchown,fchownat,lchown -F auid>=1000 -F auid!=unset -k perm_mod',
        # '-a always,exit -F arch=b64 -S chown,fchown,fchownat,lchown -F auid>=1000 -F auid!=unset -k perm_mod',
      ]
    end
    audit['xattr'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258179: RHEL 9 must audit all uses of the setxattr, fsetxattr, lsetxattr, removexattr, fremovexattr, and lremovexattr system calls.'
      configuration['rules'] = %w(
        setxattr
        fsetxattr
        lsetxattr
        removexattr
        fremovexattr
        lremovexattr
      )
    end
    audit['umount'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258180: RHEL 9 must audit all uses of umount system calls.'
      configuration['rule'] = '/usr/bin/umount'
    end
    audit['chacl'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258181: RHEL 9 must audit all uses of the chacl command.'
      configuration['rule'] = '-a always,exit -F path=/usr/bin/chacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_mod'
    end
    audit['setfacl'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258182: RHEL 9 must audit all uses of the setfacl command.'
      configuration['rule'] = '-a always,exit -F path=/usr/bin/setfacl -F perm=x -F auid>=1000 -F auid!=unset -k perm_mod'
    end
    audit['chcon'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258183: RHEL 9 must audit all uses of the chcon command.'
      configuration['rule'] = '-a always,exit -F path=/usr/bin/chcon -F perm=x -F auid>=1000 -F auid!=unset -k perm_mod'
    end
    audit['semanage'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258184: RHEL 9 must audit all uses of the semanage command.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/semanage -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update
'
    end
    audit['setfiles'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258185: RHEL 9 must audit all uses of the setfiles command.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/setfiles -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update
'
    end
    audit['setsebool'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258186: RHEL 9 must audit all uses of the setsebool command.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/setsebool -F perm=x -F auid>=1000 -F auid!=unset -F key=privileged
'
    end
    audit['files'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258187: RHEL 9 must audit all uses of the rename, unlink, rmdir, renameat, and unlinkat system calls.'
      configuration['rules'] = []

      supported_arches.each do |arch|
        configuration['rules'] << "-a always,exit -F arch=b#{arch} -S rename,unlink,rmdir,renameat,unlinkat -F auid>=1000 -F auid!=unset -k delete"
      end
    end
    audit['file'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258188: RHEL 9 must audit all uses of the truncate, ftruncate, creat, open, openat, and open_by_handle_at system calls.'
      configuration['rules'] = []

      supported_arches.each do |arch|
        %w(PERM ACCES).each do |param|
          configuration['rules'] << "-a always,exit -F arch=b#{arch} -S truncate,ftruncate,creat,open,openat,open_by_handle_at -F exit=-E#{param} -F auid>=1000 -F auid!=unset -k perm_access"
        end
      end
    end
    audit['delete_module'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258189: RHEL 9 must audit all uses of the delete_module system call.'
      configuration['rules'] = []

      supported_arches.each do |arch|
        configuration['rules'] << "-a always,exit -F arch=b#{arch} -S delete_module -F auid>=1000 -F auid!=unset -k module_chng"
      end
    end
    audit['init_module'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258190: RHEL 9 must audit all uses of the init_module and finit_module system calls.'
      configuration['rules'] = %w(
        init_module
        finit_module
      )
    end
    audit['chage'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258191: RHEL 9 must audit all uses of the chage command.'
      configuration['rule'] = '/usr/bin/chage'
    end
    audit['chsh'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258192: RHEL 9 must audit all uses of the chsh command.'
      configuration['rule'] = '/usr/bin/chsh'
    end
    audit['crontab'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258193: RHEL 9 must audit all uses of the crontab command.'
      configuration['rule'] = '/usr/bin/crontab'
    end
    audit['gpasswd'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258194: RHEL 9 must audit all uses of the gpasswd command.'
      configuration['rule'] = '/usr/bin/gpasswd'
    end
    audit['kmod'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258195: RHEL 9 must audit all uses of the kmod command.'
      configuration['rule'] = '/usr/bin/kmod'
    end
    audit['newgrp'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258196: RHEL 9 must audit all uses of the newgrp command.'
      configuration['rule'] = '/usr/bin/newgrp'
    end
    audit['pam_timestamp_check'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258197: RHEL 9 must audit all uses of the pam_timestamp_check command.'
      configuration['rule'] = '/usr/sbin/pam_timestamp_check'
    end
    audit['passwd'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258198: RHEL 9 must audit all uses of the passwd command.'
      configuration['rule'] = '/usr/bin/passwd'
    end
    audit['postdrop'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258199: RHEL 9 must audit all uses of the postdrop command.'
      configuration['rule'] = '/usr/sbin/postdrop'
    end
    audit['postqueue'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258200: RHEL 9 must audit all uses of the postqueue command.'
      configuration['rule'] = '/usr/sbin/postqueue'
    end
    audit['ssh-agent'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258201: RHEL 9 must audit all uses of the ssh-agent command.'
      configuration['rule'] = '/usr/bin/ssh-agent'
    end
    audit['ssh-keysign'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258202: RHEL 9 must audit all uses of the ssh-keysign command.'
      configuration['rule'] = '/usr/libexec/openssh/ssh-keysign'
    end
    audit['su'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258203: RHEL 9 must audit all uses of the su command.'
      configuration['rule'] = '/usr/bin/su'
    end
    audit['sudo'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258204: RHEL 9 must audit all uses of the sudo command.'
      configuration['rule'] = '/usr/bin/sudo'
    end
    audit['sudoedit'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258205: RHEL 9 must audit all uses of the sudoedit command.'
      configuration['rule'] = '/usr/bin/sudoedit'
    end
    audit['unix_chkpwd'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258206: RHEL 9 must audit all uses of the unix_chkpwd command.'
      configuration['rule'] = '/usr/sbin/unix_chkpwd'
    end
    audit['unix_update'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258207: RHEL 9 must audit all uses of the unix_update command.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/unix_chkpwd -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
    end
    audit['userhelper'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258208: RHEL 9 must audit all uses of the userhelper command.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/userhelper -F perm=x -F auid>=1000 -F auid!=unset -k privileged-unix-update'
    end
    audit['usermod'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258209: RHEL 9 must audit all uses of the usermod command.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/usermod -F perm=x -F auid>=1000 -F auid!=unset -k privileged-usermod'
    end
    audit['mount'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258210: RHEL 9 must audit all uses of the mount command.'
      configuration['rule'] = '-a always,exit -F path=/usr/bin/mount -F perm=x -F auid>=1000 -F auid!=unset -k privileged-mount'
    end
    audit['init'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258211: Successful/unsuccessful uses of the init command in RHEL 9 must generate an audit record.'
      configuration['rule'] = '-a always,exit -F path=/usr/sbin/init -F perm=x -F auid>=1000 -F auid!=unset -k privileged-init'
    end
    audit['poweroff'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258212: Successful/unsuccessful uses of the poweroff command in RHEL 9 must generate an audit record.'
      configuration['rule'] = '/usr/sbin/poweroff'
    end
    audit['reboot'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258213: Successful/unsuccessful uses of the reboot command in RHEL 9 must generate an audit record.'
      configuration['rule'] = '/usr/sbin/reboot'
    end
    audit['shutdown'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258214: Successful/unsuccessful uses of the shutdown command in RHEL 9 must generate an audit record.'
      configuration['rule'] = '/usr/sbin/shutdown'
    end
    audit['umount'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258215: Successful/unsuccessful uses of the umount system call in RHEL 9 must generate an audit record.'
      configuration['rules'] = []
      supported_arches.each do |arch|
        configuration['rules'] << "-a always,exit -F arch=b#{arch} -S umount -F auid>=1000 -F auid!=unset -k perm_mod"
      end
    end
    audit['umount2'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258216: Successful/unsuccessful uses of the umount2 system call in RHEL 9 must generate an audit record.'
      configuration['rules'] = []
      supported_arches.each do |arch|
        configuration['rules'] << "-a always,exit -F arch=b#{arch} -S umount2 -F auid>=1000 -F auid!=unset -k perm_mod"
      end
    end
    audit['sudoers'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258217: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/sudoers.'
      configuration['rule'] = '-w /etc/sudoers -p wa -k identity'
    end
    audit['sudoers.d'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258218: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/sudoers.d/ directory.'
      configuration['rule'] = '-w /etc/sudoers.d/ -p wa -k identity'
    end
    audit['group'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258219: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/group.'
      configuration['rule'] = '-w /etc/group -p wa -k identity'
    end
    audit['gshadow'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258220: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/gshadow.'
      configuration['rule'] = '-w /etc/gshadow -p wa -k identity'
    end
    audit['opasswd'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258221: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/opasswd.'
      configuration['rule'] = '-w /etc/security/opasswd -p wa -k identity'
    end
    audit['passwd'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258222: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/passwd.'
      configuration['rule'] = '-w /etc/passwd -p wa -k identity'
    end
    audit['shadow'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258223: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /etc/shadow.'
      configuration['rule'] = '-w /etc/shadow -p wa -k identity'
    end
    audit['faillock'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258224: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /var/log/faillock.'
      configuration['rule'] = '-w /var/log/faillock -p wa -k logins'
    end
    audit['lastlog'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258225: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /var/log/lastlog.'
      configuration['rule'] = '-w /var/log/lastlog -p wa -k logins'
    end
    audit['tallylog'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258226: RHEL 9 must generate audit records for all account creations, modifications, disabling, and termination events that affect /var/log/tallylog.'
      configuration['rule'] = '-w /var/log/tallylog -p wa -k logins'
    end
    audit['critical'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258227: RHEL 9 must take appropriate action when a critical audit processing failure occurs.'
      configuration['rule'] = '-f 2'
    end
    audit['loginuid'].tap do |configuration|
      configuration['managed'] = true
      configuration['title'] = 'SV-258228: RHEL 9 audit system must protect logon UIDs from unauthorized change.'
      configuration['rule'] = '--loginuid-immutable'
    end
    audit['unauthorized'].tap do |configuration|
      configuration['managed'] = false
      configuration['title'] = 'SV-258229: RHEL 9 audit system must protect auditing rules from unauthorized change.'
      configuration['rule'] = '-e 2'
    end
  end
  # controls['sshd'].tap do |configuration|
  #  #configuration[] ''
  # end
  # control['sysctl'].tap do |configuration|
  #  #configuration[] = ''
  # end
end
