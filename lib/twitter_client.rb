class TwitterClient
  MAX_ATTEMPTS = 3

  class << self
    def with_rate_limit(method, *args)
      attempts = 0
      begin
        attempts += 1
        client.send(method, *args)
      rescue Twitter::Error::TooManyRequests => error
        puts "Wait more #{ error.rate_limit.reset_in } seconds"
        if attempts < MAX_ATTEMPTS
          sleep error.rate_limit.reset_in + 1
          retry
        end
      end
    end

    def client
      @client ||= Twitter::REST::Client.new do |config|
        config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
        config.access_token = ENV['TWITTER_OAUTH_TOKEN']
        config.access_token_secret = ENV['TWITTER_OAUTH_TOKEN_SECRET']
      end
    end
  end
end