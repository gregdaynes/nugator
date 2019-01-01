module Nugator
  module Operation
    module Source
      class Validate
        def call(**options)
          url = options[:url]

          raise Nugator::Error::InvalidRequest if url.nil?
        end
      end
    end
  end
end
