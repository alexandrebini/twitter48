require 'spec_helper'

describe Api::TimelinesController do
  it '#show' do
    VCR.use_cassette('timeline') do
      get :show, scren_name: build(:user).screen_name, format: :json
      response.success?.must_equal true

      timeline = JSON.parse(response.body)
      timeline.must_be_kind_of Enumerable
      timeline.each do |tweet|
        tweet['user'].wont_be_empty
        tweet['user'].wont_be_empty
        tweet['full_text'].wont_be_empty
        tweet['url'].wont_be_empty
      end
    end
  end
end