# frozen_string_literal: false

default['cookbook']['harden']['controls']['sssd'].tap do |control|
  control['sssd_auth_ca_db'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-258131: RHEL 9, for PKI-based authentication, must validate certificates by constructing a certification path (which includes status information) to an accepted trust anchor.'
    configuration['source'] = 'https://dl.dod.cyber.mil/wp-content/uploads/pki-pke/zip/unclass-certificates_pkcs7_DoD.zip'
  end
  control['pki_authentication'].tap do |configuration|
    configuration['managed'] = false # TODO
    configuration['title'] =
      'SV-258132: RHEL 9 must map the authenticated identity to the user or group account for PKI-based authentication.'
    configuration['domain'] = 'testing.test'
  end
end
