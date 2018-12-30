module Nugator
  module Interactor
    class FetchSource
      include Nugator::NUGATOR_CONTAINER[
        'operation.source.fetch',
        'operation.source.parse_item',
      ]

      def call(source)
        results = fetch.call(source.url)

        results.map do |raw_item|
          parse_item.call(raw_item)
        end
      end
    end
  end
end
