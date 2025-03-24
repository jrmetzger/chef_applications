# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: mount
#
# Copyright:: 2025, The Authors, All Rights Reserved.

mount_points = {}

node['cookbook']['controls']['mount'].each do |name, control|
  next unless control['managed']

  # Split name and options
  mount, option = name.split('-')
  mount_prefix = mount.gsub('/', '_')

  # Set fstype and device based on mount name
  case name
  when '/dev/shm'
    fstype = 'tmpfs'
    device = 'tmpfs'
  else
    fstype = 'xfs' # Fixed: Assign 'xfs' to fstype
    device = "/dev/#{node['cookbook']['mount_volume_group']}/#{node['cookbook']['mount_volume_name']}#{node['cookbook']['mount_volume_extension']}-#{mount_prefix}#{node['cookbook']['mount_volume_extension']}"
  end

  # Initialize the mount point entry if it doesn't exist
  mount_points[mount] ||= control.dup
  mount_points[mount]['backup_path'] = "/mnt/backup_#{mount_prefix}"
  mount_points[mount]['options'] ||= [] # Ensure options are initialized as an array
  mount_points[mount]['options'] << option

  # Add additional attributes to mount point
  mount_points[mount]['fstype'] = fstype  # Assign the correct fstype value
  mount_points[mount]['device'] = device  # Assign the dynamic device value
end

# Iterate over each mount point and create logical volumes, backup, and mount
mount_points.each do |name, control|
  # TODO: Create Mount Is Hard on ec2

  # Create logical volume
  lvm_logical_volume name do
    group node['cookbook']['mount_volume_group']
    size node['cookbook']['mount_storage']
    filesystem control['fstype']
    action :create
  end

  # Initialize Resources
  directory control['backup_path'] do
    recursive true
    action :create
  end

  execute "Backup Mount Point #{name}" do
    command "rsync -ap #{name}/ #{control['backup_path']}/"
    action :nothing
  end

  execute "Restore Mount Point #{name}" do
    command "rsync -ap #{control['backup_path']}/ #{name}/"
    notifies :remove, "directory[#{control['backup_path']}]", :immediately
    action :nothing
  end

  # Mount the logical volume with options
  mount control['title'] do
    mount_point name
    device control['device'] # Use the correct device path
    fstype control['fstype']
    dump 0
    pass 0
    options "defaults,#{control['options'].join(',')}"
    action [:mount, :enable]
    notifies :run, "execute[Backup Mount Point #{name}]", :before
    notifies :run, "execute[Restore Mount Point #{name}]", :immediately
    only_if "lvdisplay /dev/#{node['cookbook']['mount_volume_group']}/#{name}"  # Ensure LV exists before mounting
  end
end
