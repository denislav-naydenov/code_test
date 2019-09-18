# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
  config.filter_sensitive_data('<LEAD_API_ACCESS_TOKEN>') { ENV.fetch('LEAD_API_ACCESS_TOKEN') }
  config.filter_sensitive_data('<LEAD_API_PGUID>') { ENV.fetch('LEAD_API_PGUID') }
  config.filter_sensitive_data('<LEAD_API_PACCNAME>') { ENV.fetch('LEAD_API_PACCNAME') }
  config.filter_sensitive_data('<LEAD_API_PPARTNER>') { ENV.fetch('LEAD_API_PPARTNER') }
end
