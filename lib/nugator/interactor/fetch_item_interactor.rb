module Nugator
  module Interactor
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
        @show_content = options[:content]

        validate_request

        handle_reversed_date_range

        items = fetch_items || []

        filter_content(items)
      end

      private

      attr_reader :ids, :count, :show_content, :before, :since, :tags

      def validate_request
        validate_ids_request
        validate_count_request
      end

      def validate_ids_request
        raise Nugator::Error::InvalidRequest if ids && (tags  ||
                                                        count ||
                                                        since ||
                                                        before)
      end

      def validate_count_request
        raise Nugator::Error::InvalidRequest if count && (count <= 0 ||
                                                          count > 10)
      end

      def fetch_items
        if ids
          items_by_ids
        else
          items_by_combinator
        end
      end

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

      def filter_content(items)
        return items if show_content

        items.each do |item|
          item.delete_field(:content)
        end
      end
    end
  end
end
