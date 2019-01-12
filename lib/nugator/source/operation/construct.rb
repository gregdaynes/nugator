module Source
  module Operation
    class Construct
      def call(**options)
        OpenStruct.new(
          url: options[:url]
        )
      end
    end
  end
end
