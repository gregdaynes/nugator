require 'dry-auto_inject'

module Nugator
  class Container
    extend Dry::Container::Mixin

    namespace(:repository) do
    end

    namespace(:interactor) do
      register(:fetch_source) { Object.const_get('Nugator::Interactor::FetchSourceContent').new }
      register(:fetch_item) { Object.const_get('Nugator::Interactor::FetchItem').new }
      register(:create_source) { Object.const_get('Nugator::Interactor::CreateSource').new }
    end

    namespace(:operation) do
      namespace(:source) do
        register(:fetch) { Object.const_get('Nugator::Operation::Source::FetchContent').new }
        register(:parse_item) { Object.const_get('Nugator::Operation::Source::ParseItem').new }
        register(:validate) { Object.const_get('Nugator::Operation::Source::Validate').new }
        register(:construct) { Object.const_get('Nugator::Operation::Source::Construct').new }
        register(:store) { Object.const_get('Nugator::Operation::Source::Store').new }
      end

      namespace(:item) do
        register(:validate_request) { Object.const_get('Nugator::Operation::Item::ValidateRequest').new }
        register(:fetch_item) { Object.const_get('Nugator::Operation::Item::FetchItem').new }
        register(:filter_content) { Object.const_get('Nugator::Operation::Item::FilterContent').new }
      end

      namespace(:intelligence) do
        register(:service) { Object.const_get('Nugator::Operation::Intelligence::Watson').new }
      end
    end
  end

  NUGATOR_CONTAINER = Dry::AutoInject(Container)
end
