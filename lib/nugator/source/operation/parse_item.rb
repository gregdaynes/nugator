module Source
  module Operation
    class ParseItem
      def call(raw_source_item)
        @raw_source_item = raw_source_item

        OpenStruct.new(
          author: author,
          published_date: published_date,
          content: raw_source_item.description,
          title: raw_source_item.title,
          link: raw_source_item.link
        )
      end

      private

      attr_reader :raw_source_item

      def author
        raw_source_item.author || raw_source_item.dc_creator
      end

      def published_date
        return Time.now unless raw_source_item.pubDate

        DateTime.parse(raw_source_item.pubDate.to_s)
      end
    end
  end
end
