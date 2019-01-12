module Item
  module Operation
    class ValidateRequest
      include Nugator::NUGATOR_CONTAINER[]

      def call(**options)
        @ids    = options[:id]
        @count  = options[:count]
        @before = options[:before]
        @since  = options[:since]
        @tags   = options[:tags]

        validate_ids_request
        validate_count_request
      end

      private

      attr_reader :ids, :count, :before, :since, :tags

      def validate_ids_request
        raise Error::InvalidRequest if ids && (tags  ||
                                                        count ||
                                                        since ||
                                                        before)
      end

      def validate_count_request
        raise Error::InvalidRequest if count && (count <= 0 ||
                                                          count > 10)
      end
    end
  end
end
