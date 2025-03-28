# frozen_string_literal: false

default['cookbook']['harden']['controls']['usbguard'].tap do |control|
  control['generate_policy'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258038: RHEL 9 must block unauthorized peripherals before establishing a connection.'
  end
end
