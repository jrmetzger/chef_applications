# frozen_string_literal: false

default['cookbook']['harden']['controls']['sssd'].tap do |control|
  control['pki_authentication'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258132: RHEL 9 must map the authenticated identity to the user or group account for PKI-based authentication.'
  end
end
