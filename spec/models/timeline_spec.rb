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