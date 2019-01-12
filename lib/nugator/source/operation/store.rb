module Source
  module Operation
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
