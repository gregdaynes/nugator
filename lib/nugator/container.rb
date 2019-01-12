require 'dry-auto_inject'

module Nugator
  class Container
    extend Dry::Container::Mixin

    namespace(:repository) do
    end

    namespace(:interactor) do
      register(:fetch_source) { Object.const_get('Source::Interactor::FetchSourceContent').new }
      register(:fetch_item) { Object.const_get('Item::Interactor::FetchItem').new }
      register(:create_source) { Object.const_get('Source::Interactor::CreateSource').new }

      namespace(:natural_language_processor) do
        register(:text_analysis) { Object.const_get('NaturalLanguageProcessor::Interactor::TextAnaylsis').new }
      end
    end

    namespace(:operation) do
      namespace(:source) do
        register(:fetch) { Object.const_get('Source::Operation::FetchContent').new }
        register(:parse_item) { Object.const_get('Source::Operation::ParseItem').new }
        register(:validate) { Object.const_get('Source::Operation::Validate').new }
        register(:construct) { Object.const_get('Source::Operation::Construct').new }
        register(:store) { Object.const_get('Source::Operation::Store').new }
      end

      namespace(:item) do
        register(:validate_request) { Object.const_get('Item::Operation::ValidateRequest').new }
        register(:fetch_item) { Object.const_get('Item::Operation::FetchItem').new }
        register(:filter_content) { Object.const_get('Item::Operation::FilterContent').new }
      end

      namespace(:natural_language_processor) do
        register(:service) { Object.const_get('NaturalLanguageProcessor::Operation::Watson').new }
      end
    end
  end

  NUGATOR_CONTAINER = Dry::AutoInject(Container)
end
