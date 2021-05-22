# frozen_string_literal: true

require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'paylense-sdk'
require 'webmock/rspec'
require 'vcr'
WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    stub_request(:get, /api-sandbox.paylense.com/)
      .with(headers: {
              "Content-Type": 'application/json'
            })
      .to_return(status: 200, body: 'stubbed_response', headers: {})
  end
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end
