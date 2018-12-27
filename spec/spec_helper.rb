require 'bundler/setup'
require 'nugator'
require 'pry'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

RSpec.configure do |config|
  # enable flags like ---only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # disable RSpec exposing methods globally on `module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
