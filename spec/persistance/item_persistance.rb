require 'yaml'
require 'time'

module Persistance
  class Item
    attr_reader :data

    def initialize
      @data = YAML.load_file(File.join(__dir__, 'yaml/items.yml'))
    end

    def get_items_by_ids(ids)
      results = ids.map do |id|
        item = data[id]
        OpenStruct.new(item) unless item.nil?
      end

      results.compact
    end

    def get_items_by_count(count)
      results = (1..count).map do |id|
        item = data[id]
        OpenStruct.new(item) unless item.nil?
      end

      results.compact
    end

    def get_items_since(time)
      results = data.select do |item|
        next if item.nil?

        published_date = item['published_date']
        Time.parse(published_date) >= time
      end

      results.map { |item| OpenStruct.new(item) }
    end

    def get_items_before(time)
      results = data.select do |item|
        next if item.nil?

        published_date = item['published_date']
        Time.parse(published_date) <= time
      end

      results.map { |item| OpenStruct.new(item) }
    end

    def get_items_with_tags(tags)
      results = data.select do |item|
        next if item.nil?

        item_tags = item['tags']

        common_tags = item_tags & tags

        common_tags && !common_tags.empty?
      end

      results.map { |item| OpenStruct.new(item) }
    end

    def get_items_by_date_range(since, before)
      results = data.select do |item|
        next if item.nil?

        published_date = Time.parse(item['published_date'])

        item if published_date >= since && published_date <= before
      end

      results.map { |item| OpenStruct.new(item) }
    end

    def get_items_by_combinator(**options)
      since  = options[:since]
      before = options[:before]
      count  = options[:count]
      tags   = options[:tags]

      results = data.select do |item|
        next if item.nil?

        if since || before
          published_date = Time.parse(item['published_date'])
          next if since && published_date < since
          next if before && published_date > before
        end

        if tags
          item_tags = item['tags']
          next if item_tags.nil?
          next if item_tags == false
          next if (item_tags & tags).empty?
        end

        item
      end

      results = results.sample(count) if count

      results.map { |item| OpenStruct.new(item) }
    end
  end
end
