require 'spec_helper'

describe Followers do
  it 'its a kind of enumerable' do
    Followers.new.must_be_kind_of Enumerable
  end

  describe 'class methods' do
    it '#find' do
      VCR.use_cassette('followers') do
        Followers.must_respond_to :find
        Followers.find(build(:user).screen_name).must_be_instance_of Followers
      end
    end

    it '#from_client' do
      VCR.use_cassette('followers') do
        twiter_followers = TwitterClient.followers(build(:user).screen_name)
        Followers.must_respond_to :from_client
        Followers.from_client(twiter_followers).must_be_instance_of Followers
      end
    end

    it '#in_common' do
      screen_names = %w(dhh wycats josevalim)

      VCR.use_cassette('common_followers', { match_requests_on: [:uri_without_cursor] }) do
        users = screen_names.map do |screen_name|
          TwitterClient.follower_ids(screen_name)
        end

        Followers.must_respond_to :in_common
        in_common = Followers.in_common(screen_names: screen_names)
        in_common.must_be_kind_of Enumerable
        in_common.size.wont_equal 0
      end
    end
  end
end