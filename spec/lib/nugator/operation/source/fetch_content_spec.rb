require 'spec_helper'

require 'nugator'

RSpec.describe Nugator::Operation::Source::FetchContent do
  let(:instance) { described_class.new }
  let(:url) { 'http://www.golfchannel.com/rss/124552/feed.xml' }

  subject { instance.call(url) }

  describe '#call' do
    context 'when source is available' do
      it 'fetches the source' do
        expect(subject).to be_a(Array)
      end
    end

    context 'when source is unavailable' do
      let(:url) { 'http://example.com' }

      it 'returns false' do
        expect { subject }.to raise_error(RSS::NotWellFormedError)
      end
    end
  end
end
