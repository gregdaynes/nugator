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
  end
end
