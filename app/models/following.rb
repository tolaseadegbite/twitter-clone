class Following < ApplicationRecord
  belongs_to :user, counter_cache: :followings_count
  belongs_to :following_user, class_name: "User", counter_cache: :followers_count
  validates :user_id, uniqueness: { scope: :following_user_id }
end
