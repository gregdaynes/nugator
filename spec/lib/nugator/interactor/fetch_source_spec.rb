require 'spec_helper'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Nugator::Interactor::FetchSource do
  let(:instance) { described_class.new }
  let(:storage) { Persistance.new }
  let(:source) do
    OpenStruct.new(url: 'http://www.golfchannel.com/rss/124552/feed.xml')
  end

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('repository.items', storage)
  end

  subject { instance.call(source) }

  it 'fetches source and stores items' do
    subject

    expect(storage.all.count).to be > 0
  end
end

class Persistance
  def initialize
    @data = []
  end

  def create(item)
    data.push(item)
  end

  def all
    data
  end

  private

  attr_reader :data
end
