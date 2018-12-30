require 'dry-auto_inject'

module Nugator
  class Container
    extend Dry::Container::Mixin

    namespace(:repository) do
      register(:item) { Class.new }
    end

    namespace(:interactor) do
      register(:fetch_source) { Object.const_get('Nugator::Interactor::FetchSourceContent').new }
      register(:fetch_item) { Object.const_get('Nugator::Interactor::FetchItem').new }
    end

    namespace(:operation) do
      namespace(:source) do
        register(:fetch) { Object.const_get('Nugator::Operation::Source::FetchContent').new }
        register(:parse_item) { Object.const_get('Nugator::Operation::Source::ParseItem').new }
      end
    end
  end

  NUGATOR_CONTAINER = Dry::AutoInject(Container)
end
