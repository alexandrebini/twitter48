require 'spec_helper'

describe User do
  it 'must have a scren name' do
    build(:user, screen_name: nil).valid?.must_equal false
    build(:user, screen_name: 'foo').valid?.must_equal true
  end

  it 'must have an url' do
    build(:user, url: nil).valid?.must_equal false
    build(:user, url: 'http://google.com').valid?.must_equal true
  end

  it 'have a timeline' do
    VCR.use_cassette('timeline') do
      user = build(:user)
      user.must_respond_to :timeline
      user.timeline.must_be_instance_of Timeline
    end
  end

  it 'have followers' do
    VCR.use_cassette('followers') do
      user = build(:user)
      user.must_respond_to :followers
      user.followers.must_be_instance_of Followers
    end
  end

  describe 'class methods' do
    it '#find' do
      VCR.use_cassette('user') do
        User.must_respond_to :find
        User.find(build(:user).screen_name).must_be_instance_of User
      end
    end

    it '#from_client' do
      VCR.use_cassette('user') do
        twiter_user = TwitterClient.user(build(:user).screen_name)
        User.must_respond_to :from_client
        User.from_client(twiter_user).must_be_instance_of User
      end
    end
  end
end