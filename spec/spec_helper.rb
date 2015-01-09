ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

VCR.configure do |config|
  config.default_cassette_options = { match_requests_on: [:path] }
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
  config.ignore_localhost = true

  without_cursor = VCR.request_matchers.uri_without_param(:cursor)
  config.register_request_matcher(:uri_without_cursor, &without_cursor)
end

class Minitest::Spec
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include FactoryGirl::Syntax::Methods
end

Minitest::Reporters.use!
FactoryGirl.find_definitions