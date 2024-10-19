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
rspec spec/
```

## Usage

To run the application, use the following command format:

```bash
ruby client_search.rb [command] [options] [file_path]
```

### Commands

* search [field] [query]: Search for clients by specified field (id, name, email).
* duplicates: Find duplicate emails.

### Example Usage

```bash
ruby client_search.rb search name "John"
ruby client_search.rb duplicates
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