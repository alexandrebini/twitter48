require 'spec_helper'

describe Tweet do
  it 'must have a full text' do
    build(:tweet, full_text: nil).valid?.must_equal false
    build(:tweet, full_text: 'foo').valid?.must_equal true
  end

  it 'must have an url' do
    build(:tweet, url: nil).valid?.must_equal false
    build(:tweet, url: 'http://google.com').valid?.must_equal true
  end

  it 'must belongs to an user' do
    build(:tweet, user: nil).valid?.must_equal false
    build(:tweet, user: build(:user)).valid?.must_equal true
  end

  describe 'class methods' do
    it '#from_client' do
      VCR.use_cassette('timeline') do
        twiter_tweet = TwitterClient.user_timeline('alexandrebini').first
        Tweet.must_respond_to :from_client
        Tweet.from_client(twiter_tweet).must_be_instance_of Tweet
      end
    end
  end
end