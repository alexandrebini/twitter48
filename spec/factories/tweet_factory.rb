FactoryGirl.define do
  factory :tweet do
    user { build(:user) }
    full_text { Faker::Lorem.paragraph }
    url { Faker::Internet.url }
  end
end