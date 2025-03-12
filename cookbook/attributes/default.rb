# frozen_string_literal: true

default['cookbook']['controls'].tap do |controls|
  controls['audit'].tap do |audit|
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
  end
end
