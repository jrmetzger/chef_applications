# frozen_string_literal: false

default['cookbook']['harden']['controls']['chrony'].tap do |control|
  control['port'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257946: RHEL 9 must disable the chrony daemon from acting as a server.'
    configuration['value'] = '0'
  end
  control['cmdport'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257947: RHEL 9 must disable network management of the chrony daemon.'
    configuration['value'] = '0'
  end
end

# SV-257945: RHEL 9 must securely compare internal information system clocks at least every 24 hours.
# SV-257948: RHEL 9 systems using Domain Name Servers (DNS) resolution must have at least two name servers configured.
# SV-257949: RHEL 9 must configure a DNS processing mode set be Network Manager.
