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

    def in_common(screen_names, limit: 50)
      follower_ids = screen_names.map do |screen_name|
        TwitterClient.follower_ids(screen_name).attrs[:ids]
      end
      common_ids = follower_ids.inject(:&).first(limit)
      TwitterClient.users(common_ids).to_a.map do |twitter_user|
        User.from_client(twitter_user)
      end
    end
  end
end