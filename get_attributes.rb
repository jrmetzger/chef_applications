#!/usr/bin/env ruby

require 'chef'

# Load the Chef Node object
node_name = 'ip-172-31-44-171.ec2.internal'  # Replace with the node name you want to load
client = Chef::Client.new
node = client.node_load(node_name)
puts node

# Function to recursively print all node attributes
def print_node_attributes(node_object, prefix = '')
  node_object.each do |key, value|
    full_key = prefix.empty? ? key : "#{prefix}/#{key}"

    if value.is_a?(Hash)
      # Recursively call for nested hashes
      print_node_attributes(value, full_key)
    else
      # Print key-value pair
      puts "Attribute: #{full_key} => #{value}"
    end
  end
end

# Print all node attributes
print_node_attributes(node)
