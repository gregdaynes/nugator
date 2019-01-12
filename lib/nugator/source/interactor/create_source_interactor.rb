module Source
  module Interactor
    class CreateSource
      include Nugator::NUGATOR_CONTAINER[
        'operation.source.validate',
        'operation.source.construct',
        'operation.source.store'
      ]

      def call(**options)
        validate.call(options)
        source = construct.call(options)

        OpenStruct.new(store.call(source))
      end
    end
  end
end
