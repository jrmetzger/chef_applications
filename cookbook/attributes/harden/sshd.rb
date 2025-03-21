# frozen_string_literal: false

default['cookbook']['controls']['sshd'].tap do |control|
  control['UsePAM'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257986: RHEL 9 must enable the Pluggable Authentication Module (PAM) interface for SSHD'
    configuration['value'] = 'yes'
  end
end
