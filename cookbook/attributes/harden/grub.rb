# frozen_string_literal: false

default['cookbook']['controls']['grub'].tap do |control|
  control['audit_backlog_limit'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] = 'SV-258173: RHEL 9 must allocate an audit_backlog_limit of sufficient size to capture processes that start prior to the audit daemon.'
    configuration['arg'] = 'audit_backlog_limit=8192'
  end
end
