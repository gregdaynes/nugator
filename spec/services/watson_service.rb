module Service
  class Watson
    attr_reader :results

    def initialize
      @results = Marshal.load(File.binread(File.join(__dir__, 'dump/watson_results_dump')))
      nil
    end

    def call(_text, _features)
      OpenStruct.new(@results.result)
    end

    def raw
      results
    end
  end
end
