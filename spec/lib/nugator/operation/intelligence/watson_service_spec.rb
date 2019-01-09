require 'spec_helper'

require 'nugator'

RSpec.describe Nugator::Operation::Intelligence::Watson do
  let!(:item_repository) { Persistance::Item.new }
  let!(:service_dump) { Service::Watson.new }

  let(:instance) { described_class.new }
  let(:item) { item_repository.data[12] }
  let(:text) { [item['title'], item['content']].join("\n") }
  let(:features) { { categories: {}, concepts: {}, entities: {} } }
  let(:results) { service_dump.raw }

  subject { instance.call(text, features) }

  before do
    allow_any_instance_of(IBMWatson::NaturalLanguageUnderstandingV1)
      .to receive(:analyze) { results }
  end

  it 'should analyze the text and return discovered features' do
    expect(subject.categories).to include('score' => 0.814668,
                                          'label' => '/style and fashion')

    expect(subject.concepts).to include('text' => 'Hungary',
                                        'relevance'=>0.955279,
                                        'dbpedia_resource'=>'http://dbpedia.org/resource/Hungary')

    expect(subject.entities).to include('type' => 'Location',
                                        'text' => 'Szekelys',
                                        'relevance' => 0.436509,
                                        'disambiguation' => { 'subtype' => ['City'] },
                                        'count' => 1)
  end
end
