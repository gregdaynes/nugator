module Source
  module Operation
    class Validate
      def call(**options)
        url = options[:url]

        raise Error::InvalidRequest if url.nil?
      end
    end
  end
end
