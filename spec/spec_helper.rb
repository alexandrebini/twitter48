ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require 'minitest/reporters'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :webmock
end
MinitestVcr::Spec.configure!

class Minitest::Spec
  include FactoryGirl::Syntax::Methods
  Minitest::Reporters.use!
  FactoryGirl.find_definitions
end