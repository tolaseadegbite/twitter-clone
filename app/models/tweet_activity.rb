class TweetActivity < ApplicationRecord
  belongs_to :user
  belongs_to :tweet
  belongs_to :actor, class_name: "User"

  VERBS = %W[tweeted liked replied retweeted].freeze

  VERBS.each do |v|
    define_method("#{v.gsub("-", "_")}?") { v == verb }
  end
  validates :verb, presence: true, inclusion: { in: VERBS }
end
