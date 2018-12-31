module Nugator
  module Interactor
    class FetchItem
      include Nugator::NUGATOR_CONTAINER[
        'operation.item.validate_request',
        'operation.item.fetch_item',
        'operation.item.filter_content',
        repository: 'repository.item'
      ]

      def call(**options)
        validate_request.call(**options)
        items = fetch_item.call(**options) || []
        items = filter_content.call(items) unless options[:content]

        items
      end
    end
  end
end
