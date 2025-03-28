# frozen_string_literal: false

default['cookbook']['harden']['controls']['selinux'].tap do |control|
  control[''].tap do |configuration|
    configuration['managed'] = false
    configuration['title'] = 'SV-258080: RHEL 9 must configure SELinux context type to allow the use of a nondefault faillock tally directory.'
  end
end
