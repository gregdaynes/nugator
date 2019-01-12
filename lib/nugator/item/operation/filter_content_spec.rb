require 'spec_helper'

require 'nugator'

RSpec.describe Item::Operation::FilterContent do
  let!(:item_repository) { Persistance::Item.new }
  let(:instance) { described_class.new }
  let(:items) do
    [
      OpenStruct.new(item_repository.data[2]),
      OpenStruct.new(item_repository.data[3])
    ]
  end

  subject { instance.call(items) }

  it 'returns items without content' do
    expect(subject.sample.content).to be nil
  end
end
