# frozen_string_literal: false

default['cookbook']['harden']['controls']['pamd'].tap do |control|
  control[''].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'SV-258080: RHEL 9 must configure SELinux context type to allow the use of a nondefault faillock tally directory.'
  end
end

# SV-258099: RHEL 9 password-auth must be configured to use a sufficient number of hashing rounds.
#    ×  PAM Config[/etc/pam.d/password-auth] lines is expected to include password sufficient pam_unix.so sha512, any with integer arg rounds >= 5000
#    expected "password sufficient pam_unix.so sha512 shadow nullok use_authtok" to include password sufficient pam_unix.so sha512, any with integer arg rounds >= 5000
# ×  SV-258100: RHEL 9 system-auth must be configured to use a sufficient number of hashing rounds.
#    ×  PAM Config[/etc/pam.d/system-auth] lines is expected to include password sufficient pam_unix.so sha512, any with integer arg rounds >= 5000
#    expected "password sufficient pam_unix.so sha512 shadow nullok use_authtok" to include password sufficient pam_unix.so sha512, any with integer arg rounds >= 5000
