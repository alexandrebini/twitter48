class Followers < Array
  class << self
    def find(screen_name)
      twitter_followers = TwitterClient.followers(screen_name)
      self.from_client twitter_followers
    rescue Twitter::Error
      nil
    end

    def from_client(twitter_followers)
      Followers.new.tap do |followers|
        twitter_followers.each do |twitter_follower|
          followers << User.from_client(twitter_follower)
        end
      end
    end

    def in_common(screen_names)
      followers = screen_names.map{ |screen_name| self.find(screen_name) }
      followers.inject(:&)
    end
  end
end