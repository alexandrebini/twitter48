class Followers < Array
  class << self
    def find(screen_name)
      twitter_followers = TwitterClient.with_rate_limit do |client|
        client.followers(screen_name).to_a
      end
      self.from_client twitter_followers
    rescue Twitter::Error
      nil
    end

    def find_ids(screen_name)
      follower_ids = TwitterClient.with_rate_limit do |client|
        client.follower_ids(screen_name)
      end
      TwitterClient.with_rate_limit{ follower_ids.to_a }
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
      follower_ids = screen_names.map { |screen_name| find_ids(screen_name) }
      common_ids = follower_ids.inject(:&)
      users = TwitterClient.with_rate_limit { |client| client.users(common_ids) }
      TwitterClient.with_rate_limit { users.to_a }
      users.map do |twitter_user|
        User.from_client(twitter_user)
      end
    end
  end
end