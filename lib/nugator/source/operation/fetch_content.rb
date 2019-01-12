require 'open-uri'
require 'rss'

module Source
  module Operation
    class FetchContent
      def call(url)
        results = fetch_from_url(url)
        RSS::Parser.parse(results, false).items
      end

      private

      def fetch_from_url(url)
        URI.open(url).read
      end
    end
  end
end
