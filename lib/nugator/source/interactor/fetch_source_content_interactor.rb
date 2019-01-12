module Source
  module Interactor
    class FetchSourceContent
      include Nugator::NUGATOR_CONTAINER[
        'operation.source.fetch',
        'operation.source.parse_item',
        repository: 'repository.item'
      ]

      def call(source)
        results = fetch.call(source.url)

        results.map do |raw_item|
          item = parse_item.call(raw_item)
          repository.create(item)
        end
      end
    end
  end
end
