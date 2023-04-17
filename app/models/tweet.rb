class Tweet < ApplicationRecord
  HASHTAG_REGEX = /(#\w+)/
  MENTION_REGEX = /(@\w+)/

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
  has_many :replied_tweets_users, through: :reply_tweets, source: :user
  has_and_belongs_to_many :hashtags
  has_many :mentions, dependent: :destroy
  has_many :mentioned_users, through: :mentions

  before_save :parse_and_save_hashtags

  def parse_and_save_hashtags
    matches = body.scan(HASHTAG_REGEX)
    return if matches.empty?

    matches.flatten.each do |tag|
      hashtag = Hashtag.find_or_create_by(tag: tag.delete("#"))
      hashtags << Hashtag.find_or_create_by(tag: tag.delete("#"))
    end
  end

  after_save :parse_and_save_mentions

  def parse_and_save_mentions
    matches = body.scan(MENTION_REGEX)
    return if matches.empty?

    matches.flatten.each do |mention|
      mentioned_user = User.find_by(username: mention.delete("@"))
      next if mentioned_user.blank?

      next if mentions.exists?(mentioned_user: mentioned_user)

      mentions.create(mentioned_user: mentioned_user)
      Notification.create(user: mentioned_user, actor: user, verb: "mentioned-me", tweet: self)
    end
  end
end
