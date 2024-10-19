require 'json'

class ClientLoader
  def self.load_clients(file_path)
    file_path ||= 'clients.json'
    json_data = File.read(file_path)
    clients = JSON.parse(json_data, symbolize_names: true)

    # Validate each client
    clients.each do |client|
      unless valid_client?(client)
        puts "Invalid client entry: #{client}. Each client must have 'id', 'name', and 'email'."
        exit
      end
    end

    clients
  rescue Errno::ENOENT
    puts "File not found: #{file_path}"
    exit
  rescue JSON::ParserError
    puts "Error parsing JSON data."
    exit
  end

  def self.valid_client?(client)
    client.key?(:id) && client.key?(:name) && client.key?(:email)
  end
end
