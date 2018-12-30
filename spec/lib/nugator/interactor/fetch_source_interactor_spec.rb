require 'spec_helper'

require 'nugator'

RSpec.describe Nugator::Interactor::FetchSource do
  let(:instance) { described_class.new }
  let(:source) do
    OpenStruct.new(url: 'http://www.golfchannel.com/rss/124552/feed.xml')
  end

  subject { instance.call(source) }

  it 'fetches source and stores items' do
    expect(subject.sample).to be_a(OpenStruct)
    expect(subject.count).to be > 0
  end
end
