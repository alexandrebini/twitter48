class TweetSerializer < ActiveModel::Serializer
  attributes :user, :full_text, :url
end