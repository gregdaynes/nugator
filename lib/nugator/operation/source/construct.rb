module Nugator
  module Operation
    module Source
      class Construct
        def call(**options)
          OpenStruct.new(
            url: options[:url]
          )
        end
      end
    end
  end
end
