require 'spec_helper'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Nugator::Interactor::CreateSource do
  let!(:source_repository) { Persistance::Source.new }

  let(:instance) { described_class.new }

  let(:url) { 'https://example.com/rss.xml' }
  let(:source) do
    {
      url: url
    }
  end

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('repository.source', source_repository)
  end

  subject { instance.call(source) }

  it 'validates and stores the source' do
    expect(subject.id).to_not be nil
    expect(source_repository.data[2]['id']).to eq subject.id
  end
end
