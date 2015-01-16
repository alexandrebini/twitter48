require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'sprockets/railtie'

Bundler.require(*Rails.groups)

module Twitter48
  class Application < Rails::Application
    require_relative '../lib/twitter_client/twitter_client.rb'
  end
end
