require 'spec_helper'

describe Timeline do
  it 'its a kind of enumerable' do
    Timeline.new.must_be_kind_of Enumerable
  end

  describe 'class methods' do
    it '#find', vcr: { match_requests_on: [:path] } do
      Timeline.must_respond_to :find
      Timeline.find(build(:user).screen_name).must_be_instance_of Timeline
    end

    it '#from_client', vcr: { match_requests_on: [:path] }  do
      twiter_timeline = TwitterClient.user_timeline(build(:user).screen_name)
      Timeline.must_respond_to :from_client
      Timeline.from_client(twiter_timeline).must_be_instance_of Timeline
    end
  end
end


  # def find(username)
  #   twitter_timeline = TwitterClient.user_timeline(username)
  #   self.from_client twitter_timeline
  # rescue Twitter::Error
  #   nil
  # end

  # def from_client(twitter_timeline)
  #   Timeline.new.tap do |timeline|
  #     twitter_timeline.each do |twitter_tweet|
  #       timeline << Tweet.from_client(twitter_tweet)
  #     end
  #   end
  # end