# Client Search Application

This is a Ruby application for searching clients and finding duplicate emails from a JSON file.

## Features

- Load clients from a JSON file
- Search for clients by ID, name, or email
- Find duplicate emails among the clients

## Assumptions

- All of the records from the json file contains valid record
  - no duplicate ID's
  - All email are valid format
  - no blank full_name and IDs

## Requirements

- Ruby version: **3.0.0** (or similar)
- RSpec for testing

## Installation

Assuming you already have Ruby 3 installed, follow these steps to set up the project:

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/client_search.git
cd client_search
```

### 2. Install Dependencies

Install Rspec

```bash
gem install rspec
```

### 3. Run the tests

To run the tests, use the following command:

```bash
rspec spec
rspec spec/client_search_spec.rb
```

## Usage

To run the application, use the following command format:

```bash
ruby script.rb --command=<command> --field=<field> --query=<query> --file_path=<file_path>
```

### Parameters
You can pass the following parameters:

* `--command=<command>`: Specifies the action to perform.
  Valid values:
    * `search`: Searches for a client based on the specified field and query.
    * `duplicates`: Finds clients with duplicate email addresses.
    * `--field=<field>`: Defines the field to search in.
      Valid fields:
        * id
        * full_name (default)
        * email
    * `--query=<query>`: The search term for the specified field.
    * `--file_path=<file_path>`: The path to the JSON file containing client data. Defaults to `clients.json`.

### Example Usage

```bash
ruby client_search.rb --command="search" --query="JOHN"
ruby client_search.rb --command=duplicates
```

## Project Structure

```bash
/client_search
│
├── client_search.rb
├── client_loader.rb
├── clients.json
├── README.md
└── spec
    ├── client_loader_spec.rb
    ├── client_search_spec.rb
    └── fixtures
        └── clients.json
```

## File Descriptions
* `client_search.rb`: Main application file that implements the search functionality.
* `client_loader.rb`: Handles loading and validating the client data from JSON.
* `clients.json`: Sample data file containing client information.
* `spec/`: Directory containing test files.
* `spec/fixtures/clients.json`: Sample data used for testing.