class TweetActivity::DestroyRepliedJob < ApplicationJob
  queue_as :default

  def perform(actor:, tweet:)
    tweet_activities = actor.followers.map do |follower|
      TweetActivity.where(user: follower, actor: actor, tweet: tweet, verb: "replied").destroy_all
    end
    # TweetActivity.import tweet_activities, on_duplicate_key_ignore: true, batch_size: 500
  end
end
