require_relative 'token'

module TwitterClient
  MAX_ATTEMPTS = 10

  class << self
    def with_rate_limit(&block)
      attempts = 0
      begin
        attempts += 1
        prepare_to_call
        block.call(client)
      rescue Twitter::Error::TooManyRequests => error
        on_call_error(error)
        retry if attempts < MAX_ATTEMPTS
      end
    end

    def client
      @client ||= Twitter::REST::Client.new
      @client.consumer_key = Token.current.consumer_key
      @client.consumer_secret = Token.current.consumer_secret
      @client.access_token = Token.current.access_token
      @client.access_token_secret = Token.current.access_token_secret
      @client
    end

    def on_call_error(error)
      Token.current.rate_limit_reset_in = rate_limit_reset_in
      Token.current.last_call_at = Time.now
      Token.cycle!

      unless Token.current.ready?
        puts "waiting #{ Token.current.ready_in } seconds"
        sleep Token.current.ready_in
      end
    end
  end
end