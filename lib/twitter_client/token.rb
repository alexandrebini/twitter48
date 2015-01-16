module TwitterClient
  NUMBER_OF_APPS = 3

  class Token
    attr_accessor :consumer_key, :consumer_secret, :access_token,
      :access_token_secret, :last_call_at, :rate_limit_reset_in

    def initialize
      @rate_limit_reset_in = 0
    end

    def ready?
      ready_in == 0
    end

    def ready_in
      time_difference = (Time.now.to_i - last_call_at.to_i)
      if time_difference > rate_limit_reset_in
        0
      else
        rate_limit_reset_in - time_difference
      end
    end

    class << self
      def cycle!
        @current = self.next
      end

      def current
        @current ||= all.first
      end

      def next
        all.sort_by{ |token| token.ready_in }.first
      end

      def all
        @all ||= 1.upto(NUMBER_OF_APPS).map do |app_number|
          Token.new.tap do |token|
            token.consumer_key = ENV["TWITTER_CONSUMER_KEY_#{ app_number }"]
            token.consumer_secret = ENV["TWITTER_CONSUMER_SECRET_#{ app_number }"]
            token.access_token = ENV["TWITTER_ACCESS_TOKEN_#{ app_number }"]
            token.access_token_secret = ENV["TWITTER_ACCESS_TOKEN_SECRET_#{ app_number }"]
          end
        end
      end
    end
  end
end