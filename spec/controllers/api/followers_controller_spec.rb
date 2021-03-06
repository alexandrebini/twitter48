require 'spec_helper'

describe Api::FollowersController do
  it '#in_common' do
    VCR.use_cassette('common_followers') do
      get :in_common, screen_names: %w(dhh wycats), format: :json
      response.success?.must_equal true

      followers = JSON.parse(response.body)
      followers.must_be_kind_of Enumerable
      followers.each do |followers|
        followers['screen_name'].wont_be_empty
        followers['url'].wont_be_empty
      end
    end
  end
end