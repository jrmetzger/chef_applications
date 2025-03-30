#!/usr/bin/env ruby

require 'json'
require 'terminal-table'
require 'optparse'

# Parse command-line options
find_group = nil
suites = %w(
  amazon-2023
  rhel-9
)
script_dir = File.dirname(__FILE__)

OptionParser.new do |opts|
  opts.on('--group GROUP', 'Specify the group to filter by') do |group|
    find_group = group
  end

  opts.on('--suite SUITE', 'Specify the suite(s) to use (comma-separated)') do |suite|
    input_suites = suite.split(',').map(&:strip)
    # Validate that all suites are valid
    invalid_suites = input_suites - suites
    if invalid_suites.any?
      puts "Error: Invalid suite(s) provided: #{invalid_suites.join(', ')}, must be one of #{suites}"
      exit 1
    end
    suites = input_suites
  end
end.parse!

# Helper method to color the managed values
def colorize_managed(managed, value)
  if managed == true
    "\033[32m#{value}\033[0m"  # Green for true
  else
    "\033[31m#{value}\033[0m"  # Red for false
  end
end




#### Inspecinspec json . | jq '.controls[]'


profiles = {
  'rhel-9': 'redhat-enterprise-linux-9-stig-baseline',
  'amazon-2023': 'amazon-linux-2-stig-ready-baseline',
  'ubuntu-22': 'canonical-ubuntu-22.04-lts-stig-baseline'
}

parsed_controls = {}
suites.each do |suite|
  profile = profiles[:"#{suite}"]
  file_path = "cookbook/compliance/profiles/#{profile}.json"

  if File.exist?(file_path)
    puts "[INFO] Profile Parsed: #{suite}, skipping..."
  else
    puts "[INFO] Parsing Profile: #{suite}"
    system("inspec json ./cookbook/compliance/profiles/#{profile}/ > #{file_path}")
  end

  profile_hash = JSON.parse(File.read(file_path)) # Correctly parse JSON
  controls = profile_hash['controls']

  parsed_controls[suite] = {}
  controls.each do |control|
    id = control['id']
    title = control['title']
    parsed_controls[suite][id] = title
  end
end

#### Harden

data = {}
valid_suites = []
suites.each do |suite|

  file_path = "#{script_dir}/../cookbook/spec/results/default-#{suite}/default-#{suite}_attributes.json" # Replace with your actual file path
  #puts "[INFO] Preserving Attributes"
  #system("bash kitchen.sh exec #{suite} -c 'sudo cat /tmp/kitchen/nodes/#{suite}.json' > /tmp/#{suite}_attributes.json")
  #system("echo '}' >> /tmp/#{suite}_attributes.json")
  #system("sed '1d' /tmp/#{suite}_attributes.json | jq > #{file_path}")
  #system("rm -f /tmp/#{suite}}_attributes.json")
  if File.exist?(file_path)
    puts "[INFO] Found Attributes for: #{suite}"
  else
    puts "[WARN] Cannot find Attributes for: #{suite}, skipping..."
    next
  end

  ruby_hash = JSON.parse(File.read(file_path))
  if ruby_hash['default'].nil?
    puts "[WARN]: Converge Failed, No Attributes Found, skipping..."
    next
  end

  valid_suites << suite
  ruby_hash['default']['cookbook']['harden']['controls'].each do |group, controls|
    controls.each do |name, control|

      full_title = control['title']
      next unless full_title

      if full_title.is_a?(Hash)
        id, title = full_title.first # Extracts the first key-value pair
        title = title['title'] if title.is_a?(Hash) # Ensure we get the 'title' field if it's nested
      elsif full_title.is_a?(String) && full_title.include?(':')
        id, title = full_title.split(':', 2) # Split into two parts
      else
        id = 'Default'
        title = full_title
      end
      group_control = "#{group}_#{name}"


      profile_title = parsed_controls[suite][id]

      #if profile_title != title.lstrip()
      #  puts "[WARN] Harden Profile (#{title}) not equal to Compliance Profile (#{profile_title})"
      #end


      data[group_control] ||= {
        'Group' => group,
        'Control' => name,
        'Title' => title.gsub('RHEL 9', 'Linux'),
      }

      # Merge applied statuses for each suite
      data[group_control]["Applied #{suite}"] = colorize_managed(control['managed'], id)
    end
  end
end

table_rows = []
data.each do |_key, entry|
  next unless find_group.nil? || entry['Group'] == find_group
  table_rows << [entry['Group'], entry['Control'], entry['Title']] + valid_suites.map { |suite| entry["Applied #{suite}"] }
end

# Create and print the table
table = Terminal::Table.new(
  headings: %w(Group Control Title) + valid_suites.map { |suite| "Applied #{suite}" },
  rows: table_rows
)

puts table
