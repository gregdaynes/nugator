require 'spec_helper'

require 'nugator'

RSpec.describe Nugator::Operation::Source::Construct do
  let(:instance) { described_class.new }

  let(:request) do
    {
      url: 'https://example.com/feed.xml'
    }
  end

  subject { instance.call(request) }

  it 'creates a storable object' do
    expect(subject).to be_a OpenStruct
    expect(subject.url).to eq request[:url]
  end
end
