class Tweet < ApplicationRecord
  belongs_to :user
  validates :body, presence: true, length: { maximum: 280 }
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_users, through: :bookmarks, source: :user
  has_many :retweets, dependent: :destroy
  has_many :retweeted_users, through: :retweets, source: :user
  has_many :views
  has_many :viewed_users, through: :views, source: :user
  belongs_to  :parent_tweet, 
              inverse_of: :reply_tweets, 
              foreign_key: :parent_tweet_id, 
              class_name: "Tweet", 
              optional: true,
              counter_cache: :reply_tweets_count
  has_many :reply_tweets, foreign_key: :parent_tweet_id, class_name: "Tweet"
  has_and_belongs_to_many :hashtags
end
