class Timeline < Array
  class << self
    def find(screen_name)
      twitter_timeline = TwitterClient.user_timeline(screen_name)
      self.from_client twitter_timeline
    rescue Twitter::Error
      nil
    end

    def from_client(twitter_timeline)
      Timeline.new.tap do |timeline|
        twitter_timeline.each do |twitter_tweet|
          timeline << Tweet.from_client(twitter_tweet)
        end
      end
    end
  end
end