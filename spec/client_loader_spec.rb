require 'rspec'
require_relative '../client_loader'

RSpec.describe ClientLoader do
  let(:valid_json) { File.read('spec/fixtures/clients.json') }
  let(:invalid_json) { '[{"id": 1, "name": "John Doe"}]' }

  subject { ClientLoader }

  before do
    allow(File).to receive(:read).and_return(valid_json)
  end

  describe '.load_clients' do
    context 'when the JSON file is valid' do
      it 'loads clients from the file' do
        clients = subject.load_clients('spec/fixtures/clients.json')
        expect(clients).to be_an(Array)
        expect(clients.length).to eq(3)
        expect(clients.first).to include(:id, :full_name, :email)
      end
    end

    context 'when the JSON file is invalid' do
      before { allow(File).to receive(:read).and_return(invalid_json) }

      it 'raises an error for invalid JSON' do
        expect { subject.load_clients('clients.json') }.to output(/Invalid client entry/).to_stdout
      end
    end

    context 'when the file does not exist' do
      before { allow(File).to receive(:read).and_raise(Errno::ENOENT) }

      it 'raises an error' do
        expect { subject.load_clients('non_existent.json') }.to output(/File not found/).to_stdout
      end
    end

    context 'when the JSON is malformed' do
      before { allow(File).to receive(:read).and_return('malformed json') }

      it 'raises an error for malformed JSON' do
        expect { subject.load_clients('clients.json') }.to output(/Error parsing JSON data/).to_stdout
      end
    end
  end

  describe '.valid_client?' do
    context 'when the client is valid' do
      it 'returns true' do
        client = { id: 1, full_name: 'Jane Doe', email: 'jane@example.com' }
        expect(subject.valid_client?(client)).to be true
      end
    end

    context 'when the client is invalid' do
      it 'returns false' do
        client = { id: 1, full_name: 'Jane Doe' }
        expect(subject.valid_client?(client)).to be false
      end
    end
  end
end
