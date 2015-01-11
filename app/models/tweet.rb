class Tweet
  include ActiveModel::Model
  include ActiveModel::Serialization

  attr_accessor :user, :full_text, :url

  validates :user, presence: true
  validates :full_text, presence: true
  validates :url, presence: true, format: { with: URI::regexp }

  class << self
    def from_client(twitter_tweet)
      Tweet.new(full_text: twitter_tweet.full_text, url: twitter_tweet.uri.to_s,
        user: User.from_client(twitter_tweet.user))
    end
  end
end