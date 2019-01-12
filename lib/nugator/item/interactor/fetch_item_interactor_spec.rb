require 'spec_helper'
require 'time'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Item::Interactor::FetchItem do
  let!(:item_repository) { Persistance::Item.new }

  let(:instance) { described_class.new }

  let(:content) { nil }
  let(:request) do
    {
      id: nil,
      content: content,
      count: nil,
      before: nil,
      since: nil
    }
  end

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('repository.item', item_repository)

    # validate_request is not under test
    allow_any_instance_of(Item::Operation::ValidateRequest)
      .to receive(:call) { nil }

    # fetch_item is not under test
    allow_any_instance_of(Item::Operation::FetchItem)
      .to receive(:call) { [OpenStruct.new(item_repository.data[1])] }
  end

  subject { instance.call(request) }

  context 'when not requesting content' do
    it 'returns item without content' do
      expect(subject.sample.content).to be nil
    end
  end

  context 'when requesting content' do
    let(:content) { true }

    it 'returns item with content' do
      expect(subject.sample.content).to eq 'Test Content'
    end
  end
end
