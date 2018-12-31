require 'spec_helper'

require 'open-uri'

require 'nugator'

RSpec.describe Nugator::Operation::Source::FetchContent do
  let!(:source_repository) { Persistance::Source.new }

  let(:instance) { described_class.new }
  let(:url) { 'http://example.com/feed.xml' }

  subject { instance.call(url) }

  describe '#call' do
    context 'when source is available' do
      before do
        allow(URI).to receive(:open) { Tempfile.new('temp_file') }
        allow_any_instance_of(File).to receive(:read) { source_repository.source_content }
      end

      it 'fetches the source' do
        expect(subject).to be_a(Array)
      end
    end

    context 'when source is unavailable' do
      it 'returns 404' do
        expect { subject }.to raise_error(OpenURI::HTTPError, '404 Not Found')
      end
    end

    context 'when source is unreadable' do
      let(:url) { 'http://example.com' }

      it 'returns 404' do
        expect { subject }.to raise_error(RSS::NotWellFormedError)
      end
    end
  end
end
