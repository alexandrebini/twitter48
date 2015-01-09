class User
  include ActiveModel::Model
  attr_accessor :screen_name, :url, :timeline

  validates :screen_name, presence: true
  validates :url, presence: true, format: { with: URI::regexp }

  def timeline
    @timeline ||= Timeline.find(screen_name)
  end

  class << self
    def find(screen_name)
      twitter_user = TwitterClient.user(screen_name)
      self.from_client twitter_user
    rescue Twitter::Error
      nil
    end

    def from_client(twitter_user)
      User.new(screen_name: twitter_user.screen_name, url: twitter_user.uri.to_s)
    end
  end
end