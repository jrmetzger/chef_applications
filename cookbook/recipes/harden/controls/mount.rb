# frozen_string_literal: true

#
# Cookbook:: applications
# Recipe:: mount
#
# Copyright:: 2025, The Authors, All Rights Reserved.

# pv_name = node['cookbook']['harden']['mount_settings']['pv_name']
lv_name = node['cookbook']['harden']['mount_settings']['lv_name']
lv_size = node['cookbook']['harden']['mount_settings']['lv_size']

mount_points = {}
node['cookbook']['harden']['controls']['mount'].each do |name, control|
  next unless control['managed']

  # Split name and options
  mount, option = name.split('-')
  mount_title = mount.gsub('/', '_').sub(/^_/, '')
  uuid = '' # `lsblk -o UUID,MOUNTPOINT | grep #{mount}$ | awk '{print $1}'`.strip

  # Set fstype and device based on mount name
  case mount
  when 'autofs'
    # service configuration['title'] do
    #  service_name name
    #  action :masked
    # end
    next
  when '/dev/shm'
    fstype = 'tmpfs'
    device = 'tmpfs'
  when '/boot'
    fstype = 'xfs'
    device = uuid # 'UUID=1444769e-a49b-4940-ad2d-e020f2e0b64f'
  when '/boot/efi'
    fstype = 'vfat'
    device = uuid # 'UUID=7B77-95E7'
  else
    fstype = 'xfs' # Fixed: Assign 'xfs' to fstype
    device = "/dev/mapper/#{lv_name}-#{mount_title}"
  end

  # Initialize the mount point entry if it doesn't exist
  mount_points[mount] ||= control.dup
  mount_points[mount]['backup_path'] = "/mnt/backup_#{mount_title}"
  mount_points[mount]['options'] ||= [] # Ensure options are initialized as an array
  mount_points[mount]['options'] << option

  # Add additional attributes to mount point
  mount_points[mount]['fstype'] = fstype  # Assign the correct fstype value
  mount_points[mount]['device'] = device  # Assign the dynamic device value
end

# Execute 'pvcreate' for the specified volume group, only if the physical volume isn't already created
# execute "pvcreate #{pv_name}" do
#  command "pvcreate #{pv_name}"
#  not_if "pvscan | grep -q '#{pv_name}'" # Prevent running if the physical volume already exists
# end

# Execute 'vgcreate' for the specified logical volume name and volume group, only if the volume group doesn't already exist
# execute "vgcreate #{lv_name} #{pv_name}" do
#  command "vgcreate #{lv_name} #{pv_name}"
#  not_if "vgs | grep -q '#{lv_name}'" # Prevent running if the volume group already exists
# end

# Iterate over each mount point and create logical volumes, backup, and mount
mount_points.each do |name, control|
  lv_title = name.gsub('/', '_').sub(/^_/, '')

  case name
  when '/dev/shm', '/boot/efi', '/boot'
    notify_group control['title'] do
      notifies :remount, "mount[#{control['title']}]", :immediately
      notifies :enable, "mount[#{control['title']}]", :immediately
    end
  else

    # Create Backup Directory
    directory control['backup_path'] do
      recursive true
      action :create
    end

    # Create Mountpoint if not already
    directory name do
    end

    # Backup Mountpoint if Exists
    execute "Backup Mount Point #{name}" do
      command "rsync -ap #{name}/ #{control['backup_path']}/"
      action :nothing
    end

    execute "Create Logical Volume Size '#{lv_size}' with Path Basename: #{lv_title} for Group#{lv_name}" do
      command "lvcreate -L #{lv_size} -n #{lv_title} #{lv_name}"
      not_if "lvdisplay #{lv_name}/#{lv_title}"
      notifies :run, "execute[Backup Mount Point #{name}]", :before
      notifies :run, "execute[Create File System: #{control['fstype']} for '/dev/mapper/#{lv_name}-#{lv_title}']", :immediately
      notifies :mount, "mount[#{control['title']}]", :immediately
      notifies :enable, "mount[#{control['title']}]", :immediately
      notifies :run, "execute[Restore Mount Point #{name}]", :immediately
    end

    # Create File System
    execute "Create File System: #{control['fstype']} for '/dev/mapper/#{lv_name}-#{lv_title}'" do
      command "mkfs.#{control['fstype']} /dev/mapper/#{lv_name}-#{lv_title} -f"
      not_if "blkid /dev/mapper/#{lv_name}-#{lv_title} | grep -q 'TYPE=#{control['fstype']}'"
      action :nothing
    end

    # Create Logical Volume Group
    # lvm_volume_group lv_name do
    #  physical_volumes  [pv_name]
    #  wipe_signatures   true
    #
    #  # Create Logical Volume within its Group
    #  logical_volume lv_title do
    #    size        lv_size
    #    filesystem  control['fstype']
    #    mount_point name
    #    stripes     1
    #  end
    #
    #  notifies :run, "execute[Backup Mount Point #{name}]", :before
    #  notifies :remount, "mount[#{control['title']}]", :immediately
    #  notifies :enable, "mount[#{control['title']}]", :immediately
    #  notifies :run, "execute[Restore Mount Point #{name}]", :immediately
    # end

    # Restore Mount Point
    execute "Restore Mount Point #{name}" do
      command "rsync -ap #{control['backup_path']}/ #{name}/"
      notifies :delete, "directory[#{control['backup_path']}]", :immediately
      action :nothing
    end
  end
  # Mount or Remount to /etc/fstab
  mount control['title'] do
    mount_point name
    device control['device']
    fstype control['fstype']
    dump 0
    pass 0
    options "defaults,#{control['options'].join(',')}"
    supports(remount: true)
    action [:remount, :enable]
  end
end
