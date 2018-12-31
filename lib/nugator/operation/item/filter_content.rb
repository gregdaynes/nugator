module Nugator::Operation::Item
  class FilterContent
    def call(items)
      items.each do |item|
        item.delete_field(:content)
      end
    end
  end
end
