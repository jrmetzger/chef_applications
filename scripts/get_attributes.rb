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

data = {}
valid_suites = []
suites.each do |suite|
  file_path = "#{script_dir}/../cookbook/spec/results/default-#{suite}/default-#{suite}_attributes.json" # Replace with your actual file path
  next unless File.exist?(file_path)

  puts "Searching OS #{suite}"
  valid_suites << suite
  file_content = File.read(file_path)
  ruby_hash = JSON.parse(file_content)

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
