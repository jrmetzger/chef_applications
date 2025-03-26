# frozen_string_literal: false

default['cookbook']['harden']['controls']['systemd'].tap do |control|
  control['Manager.CtrlAltDelBurstAction'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257784: The systemd Ctrl-Alt-Delete burst key sequence in RHEL 9 must be disabled.'
    configuration['value'] = 'none'
  end
  control['Coredump.ProcessSizeMax'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257812: RHEL 9 must disable core dump backtraces.'
    configuration['value'] = '0'
  end
  control['Coredump.Storage'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257813: RHEL 9 must disable storing core dumps.'
    configuration['value'] = 'none'
  end
  control['ctrl-alt-del.target'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257785:The x86 Ctrl-Alt-Delete key sequence must be disabled on RHEL 9.'
    configuration['actions'] = %w(disable mask)
  end
  control['debug-shell.service'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257786: RHEL 9 debug-shell systemd service must be disabled.'
    configuration['actions'] = %w(disable mask)
  end
  control['systemd-coredump.socket'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257815: RHEL 9 must disable acquiring, saving, and processing core dumps.'
    configuration['actions'] = %w(mask)
  end
  control['kdump'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-257818: The kdump service on RHEL 9 must be disabled.'
    configuration['actions'] = %w(disable)
  end
end
