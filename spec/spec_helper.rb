require 'bundler/setup'
Bundler.require(:development)
require 'site_search'

Dir['spec/shared_examples/*.rb'].each do |file|
  require(File.expand_path(file))
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require 'dotenv/load'
Algolia.init application_id: ENV['ALGOLIA_APPLICATION_ID'],
             api_key:        ENV['ALGOLIA_API_KEY']

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<API_KEY>') { ENV['ALGOLIA_API_KEY'] }
  config.filter_sensitive_data('<APP_ID>') { ENV['ALGOLIA_APPLICATION_ID'] }
end

SiteSearch.config do |config|
  logger = ::Logger.new(STDOUT)
  logger.level = ::Logger::ERROR
  config.logger = logger
end
