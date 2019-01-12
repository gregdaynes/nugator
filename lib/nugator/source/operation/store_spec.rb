require 'spec_helper'

require 'dry/container/stub'

require 'nugator'

RSpec.describe Source::Operation::Store do
  let!(:source_repository) { Persistance::Source.new }

  let(:instance) { described_class.new }
  let(:source) do
    OpenStruct.new(
      url: 'http://example.com/feed.xml'
    )
  end

  before do
    Nugator::Container.enable_stubs!
    Nugator::Container.stub('repository.source', source_repository)
  end

  subject { instance.call(source) }

  it 'it stores the object' do
    expect(subject.id).to_not be nil
    expect(subject.url).to eq source.url
  end
end
