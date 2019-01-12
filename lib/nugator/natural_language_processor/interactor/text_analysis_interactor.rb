require 'ibm_watson'

module Nugator
  module Interactor
    module Intelligence
      class Analysis
        include Nugator::NUGATOR_CONTAINER[
          nlp_service: 'operation.intelligence.service'
        ]

        FEATURES = {
          categories: {},
          concepts: {},
          entities: {}
        }.freeze

        def call(text)
          @nlp_results = nlp_service.call(text, FEATURES)

          OpenStruct.new(
            entities: entities,
            concepts: concepts,
            categories: categories
          )
        end

        private

        def entities
          nlp_results.entities.map do |entity|
            [entity['type'], entity['text']].join('/')
          end
        end

        def concepts
          nlp_results.concepts.map { |concept| concept['text'] }
        end

        def categories
          nlp_results.categories.map { |category| category['label'] }
        end

        attr_reader :nlp_results
      end
    end
  end
end
