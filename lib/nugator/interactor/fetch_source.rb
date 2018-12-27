module Nugator
  module Interactor
    class FetchSource
      include Nugator::NUGATOR_CONTAINER[
        'operation.source.fetch',
        'operation.source.parse_item',
        repository: 'repository.items'
      ]

      def call(source)
        results = fetch.call(source.url)

        results.each do |raw_item|
          parsed_item = parse_item.call(raw_item)
          repository.create(parsed_item)
        end
      end
    end
  end
end
