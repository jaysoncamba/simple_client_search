require 'json'
require_relative 'client_loader'

class ClientSearch
  def initialize(file_path)
    @clients = ClientLoader.load_clients(file_path)
  end

  def search(query, field)
    results = @clients.select { |client| client[field].to_s.downcase.include?(query.downcase) }
    if results.empty?
      puts "No clients found with the #{field} containing '#{query}'."
    else
      results.each { |client| puts "Found: #{client[:full_name]} (#{client[:email]})" }
    end
  end

  def find_duplicate_emails
    email_counts = Hash.new(0)

    @clients.each do |client|
      email_counts[client[:email]] += 1
    end

    duplicates = email_counts.select { |_, count| count > 1 }

    if duplicates.empty?
      puts "No duplicate emails found."
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

command = ARGV[0]
file_path = ARGV[2] if ARGV.length > 2
client_search = ClientSearch.new(file_path)

case command
when 'search'
  if ARGV.length < 3
    puts "Usage: ruby client_search.rb search [field] [query] [file_path]"
  else
    field = ARGV[1].to_sym
    query = ARGV[2]
    
    if [:id, :full_name, :email].include?(field)
      client_search.search(query, field)
    else
      puts "Invalid search field. Use 'id', 'full_name', or 'email'."
    end
  end
when 'duplicates'
  client_search.find_duplicate_emails
else
  puts "Unknown command: #{command}"
end
