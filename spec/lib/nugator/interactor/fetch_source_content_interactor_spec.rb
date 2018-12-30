require 'spec_helper'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Nugator::Interactor::FetchSourceContent do
  let(:item_repository) { Persistance::Item.new }

  let(:instance) { described_class.new }
  let(:source) do
    OpenStruct.new(url: 'http://www.golfchannel.com/rss/124552/feed.xml')
  end

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('repository.item', item_repository)
  end

  subject { instance.call(source) }

  it 'fetches source and stores items' do
    items = subject
    expect(items).to be_a(Array)
    expect(subject.count).to be > 0

    item = items.first
    stored_items = item_repository.get_items_by_ids([item['id']])
    expect(stored_items).to include OpenStruct.new(item)
  end
end
