require 'yaml'
require 'time'
require 'securerandom'

module Persistance
  class Source
    attr_reader :data, :source_content

    def initialize
      @data = YAML.load_file(File.join(__dir__, 'yaml/source.yml'))
      @source_content = Marshal.load(File.binread(File.join(__dir__, 'dump/source_dump')))
    end

    def create(source)
      source.id = SecureRandom.uuid
      source_hash = Hash[source.to_h.collect { |k, v| [k.to_s, v] }]

      data << source_hash

      source_hash
    end
  end
end
