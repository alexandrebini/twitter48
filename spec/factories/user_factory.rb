FactoryGirl.define do
  factory :user do
    screen_name { Faker::Internet.user_name }
    url { Faker::Internet.url }
  end
end