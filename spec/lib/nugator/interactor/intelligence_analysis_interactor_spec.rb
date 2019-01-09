require 'spec_helper'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Nugator::Interactor::Intelligence::Analysis do
  let!(:item_repository) { Persistance::Item.new }
  let(:service) { Service::Watson.new }
  let(:instance) { described_class.new }

  let(:item) { item_repository.data[12] }
  let(:text) { [item['title'], item['content']].join("\n") }

  subject { instance.call(text) }

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('operation.intelligence.service', service)
  end

  it 'returns an object containing an array of discovered categories' do
    expect(subject.categories).to be_an Array
    expect(subject.categories).to include '/style and fashion'
  end

  it 'returns an object containing an array of discovered concepts' do
    expect(subject.concepts).to be_an Array
    expect(subject.concepts).to include 'Hungary'
  end

  it 'returns an object containing an array of discovered entities' do
    expect(subject.entities).to be_an Array
    expect(subject.entities).to include 'Person/Count Dracula'
  end
end
