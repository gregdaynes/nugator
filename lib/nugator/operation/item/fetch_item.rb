module Nugator
  module Operation
    module Item
      class FetchItem
        include Nugator::NUGATOR_CONTAINER[
          repository: 'repository.item'
        ]

        def call(**options)
          @ids    = options[:id]
          @count  = options[:count]
          @before = options[:before]
          @since  = options[:since]
          @tags   = options[:tags]

          handle_reversed_date_range

          items = ids ? items_by_ids : items_by_combinator

          items || []
        end

        private

        attr_reader :ids, :count, :before, :since, :tags

        def items_by_ids
          repository.get_items_by_ids(ids)
        end

        def items_by_combinator
          repository.get_items_by_combinator(since: since,
                                             before: before,
                                             count: count,
                                             tags: tags)
        end

        def handle_reversed_date_range
          return unless since && before

          @since, @before = @before, @since if since > before
        end
      end
    end
  end
end
