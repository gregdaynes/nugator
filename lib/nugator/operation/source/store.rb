module Nugator
  module Operation
    module Source
      class Store
        include Nugator::NUGATOR_CONTAINER[
          repository: 'repository.source'
        ]

        def call(source)
          result = repository.create(source)
          OpenStruct.new(result)
        end
      end
    end
  end
end
