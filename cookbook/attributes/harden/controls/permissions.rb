# frozen_string_literal: false

default['cookbook']['harden']['controls']['permissions'].tap do |control|
  control['library_files'].tap do |configuration|
    configuration['managed'] = true
    configuration['title'] =
      'SV-257921: RHEL 9 library files must be group-owned by root or a system account.'
    configuration['group'] = 'root'
  end
end
