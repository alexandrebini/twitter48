require 'spec_helper'

describe Api::UsersController do
  it '#show' do
    VCR.use_cassette('user') do
      get :show, scren_name: build(:user).screen_name, format: :json
      response.success?.must_equal true

      user = JSON.parse(response.body)
      user.must_be_kind_of Hash
      user['screen_name'].wont_be_empty
      user['url'].wont_be_empty
    end
  end
end