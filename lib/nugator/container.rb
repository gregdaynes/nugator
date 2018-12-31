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

      namespace(:item) do
        register(:validate_request) { Object.const_get('Nugator::Operation::Item::ValidateRequest').new }
        register(:fetch_item) { Object.const_get('Nugator::Operation::Item::FetchItem').new }
        register(:filter_content) { Object.const_get('Nugator::Operation::Item::FilterContent').new }
      end
    end
  end

  NUGATOR_CONTAINER = Dry::AutoInject(Container)
end
