class Bookmark < ApplicationRecord
  belongs_to :tweet
  belongs_to :user

  # has_many :bookmarked_users, through: :bookmarks, source: :user

  validates :user_id, uniqueness: { scope: :tweet_id }
end
