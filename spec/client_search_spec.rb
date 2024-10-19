require 'rspec'
require_relative '../client_search'

RSpec.describe ClientSearch do
  let(:clients) { JSON.parse(File.read('spec/fixtures/clients.json'), symbolize_names: true) }
  subject { ClientSearch.new('spec/fixtures/clients.json') }

  before do
    allow(ClientLoader).to receive(:load_clients).and_return(clients)
  end

  describe '#search' do
    context 'when searching by full_name' do
      it 'finds clients' do
        expect { subject.search('John', :full_name) }.to output(/Found: John Doe \(john@example.com\)/).to_stdout
      end
    end

    context 'when searching by email' do
      it 'finds clients' do
        expect { subject.search('jane@example.com', :email) }.to output(/Found: Jane Smith \(jane@example.com\)/).to_stdout
      end
    end

    context 'when the query does not match any clients' do
      it 'outputs no results' do
        expect { subject.search('Nonexistent', :full_name) }.to output(/No clients found/).to_stdout
      end
    end
  end

  describe '#find_duplicate_emails' do
    context 'when there are duplicate emails' do
      it 'identifies them' do
        expect { subject.find_duplicate_emails }.to output(/Duplicate email: john@example.com \(2 occurrences\)/).to_stdout
      end
    end

    context 'when there are no duplicates' do
      before do
        unique_clients = [{ id: 1, full_name: 'John Doe', email: 'john@example.com' }]
        allow(ClientLoader).to receive(:load_clients).and_return(unique_clients)
      end

      it 'outputs no duplicates' do
        expect { subject.find_duplicate_emails }.to output(/No duplicate emails found/).to_stdout
      end
    end
  end
end
