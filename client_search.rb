require 'json'
require_relative 'client_loader'

class ClientSearch
  def initialize(file_path)
    @clients = ClientLoader.load_clients(file_path)
  end

  def search(query, field)
    results = @clients.select { |client|
      client[field.to_sym].to_s.downcase.include?(query.downcase)
    }
    if results.empty?
      puts "No clients found with the #{field} containing '#{query}'."
    else
      results.each { |client| puts "Found: #{client[:full_name]} (#{client[:email]})" }
    end
  end

  def find_duplicates(field = :email)
    field_counts = Hash.new(0)

    @clients.each do |client|
      field_counts[client[field.to_sym]] += 1
    end

    duplicates = field_counts.select { |_, count| count > 1 }

    if duplicates.empty?
      puts "No duplicate #{field} found."
    else
      duplicates.each do |email, count|
        puts "Duplicate email: #{email} (#{count} occurrences)"
      end
    end
  end
end

if ARGV.empty?
  puts "Usage: ruby client_search.rb [command] [options] [file_path]"
  puts "Commands:"
  puts "  search [field] [query]  Search for clients by specified field."
  puts "  duplicates               Find duplicate emails."
  exit
end


# Define allowed parameters
allowed_params = %w[command field query file_path]

# Initialize a hash to store whitelisted arguments
params = {}

# Parse ARGV
ARGV.each do |arg|
  key, value = arg.split('=')
  key = key.gsub('--', '')

  if allowed_params.include?(key)
    params[key.to_sym] = value
  else
    puts "Warning: Ignoring unknown parameter --#{key}"
  end
end

command = params[:command]
field = params[:field]&.to_sym || :full_name
query = params[:query]
file_path = params[:file_path] || "clients.json"

client_search = ClientSearch.new(file_path)

if [:id, :full_name, :email].include?(field)
  case command
    when 'search'
      client_search.search(query, field)
    when 'duplicates'
      client_search.find_duplicates(field)
    else
      puts "Unknown command: #{command}"
  end
else
  puts "Invalid search field. Use 'id', 'full_name', or 'email'."
end
