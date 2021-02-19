require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "test/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.default_cassette_options = {
    :record => :new_episodes
  }
  config.filter_sensitive_data('<APP_KEY>') { ENV['APP_KEY'] }
  config.filter_sensitive_data('<APP_SECRET>') { ENV['APP_SECRET'] }
  config.filter_sensitive_data('<CALLBACK_URL>') { ENV['CALLBACK_URL'] }
  config.filter_sensitive_data('<SITE>') { ENV['SITE'] }
  config.filter_sensitive_data('<AUTH_URL>') { ENV['AUTH_URL'] }
  config.filter_sensitive_data('<ACCESS_TOKEN>') { ENV['ACCESS_TOKEN'] }
end
