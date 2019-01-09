require 'ibm_watson'

module Nugator
  module Operation
    module Intelligence
      class Watson
        def initialize
          @instance = IBMWatson::NaturalLanguageUnderstandingV1.new(
            iam_apikey: ENV['WATSON_API_KEY'],
            url:  ENV['WATSON_URL'],
            version: ENV['WATSON_VERSION']
          )
        end

        def call(text, **features)
          results = @instance.analyze(text: text, features: features).result
          OpenStruct.new(results)
        end
      end
    end
  end
end
