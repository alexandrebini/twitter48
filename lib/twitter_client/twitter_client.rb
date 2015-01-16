module TwitterClient
  MAX_ATTEMPTS = 3
  NUMBER_OF_APPS = 3

  class << self
    def with_rate_limit(&block)
      attempts = 0
      begin
        attempts += 1
        block.call client
      rescue Twitter::Error::TooManyRequests => error
        rate_limit_reset_in = error.rate_limit.reset_in
        puts "Wait more #{ rate_limit_reset_in } seconds"
        current_client_token[:rate_limit_reset_in] = rate_limit_reset_in

        if attempts < MAX_ATTEMPTS
          cycle_token!
          # sleep rate_limit_reset_in + 1
          retry
        end
      end
    end

    def client
      @client ||= Twitter::REST::Client.new
      @client.consumer_key = current_client_token[:consumer_key]
      @client.consumer_secret = current_client_token[:consumer_secret]
      @client.access_token = current_client_token[:access_token]
      @client.access_token_secret = current_client_token[:access_token_secret]
      @client
    end

    def cycle_token!
      puts "cycle token"
      @current_client_token = next_client_token
    end

    def current_client_token
      @current_client_token ||= client_tokens.first
    end

    def next_client_token
      next_index = client_tokens.index(current_client_token) + 1
      if next_index >= client_tokens.size
        client_tokens.at(0)
      else
        client_tokens.at(next_index)
      end
    end

    private
    def client_tokens
      @client_tokens ||= 1.upto(NUMBER_OF_APPS).map do |app_number|
        {
          consumer_key: ENV["TWITTER_CONSUMER_KEY_#{ app_number }"],
          consumer_secret: ENV["TWITTER_CONSUMER_SECRET_#{ app_number }"],
          access_token: ENV["TWITTER_ACCESS_TOKEN_#{ app_number }"],
          access_token_secret: ENV["TWITTER_ACCESS_TOKEN_SECRET_#{ app_number }"],
          rate_limit_reset_in: nil
        }
      end
    end
  end
end