class Retweet < ApplicationRecord
  belongs_to :tweet, counter_cache: :retweets_count
  belongs_to :user

  validates :user_id, uniqueness: { scope: :tweet_id }
end
