class TweetPresenter
    include ActionView::Helpers::DateHelper
    include Rails.application.routes.url_helpers

    attr_reader :tweet, :current_user

    def initialize(tweet:, current_user:)
        @tweet = tweet
        @current_user = user
    end
    
    delegate :user, :body, :likes_count, to: :tweet
    delegate :display_name, :avatar, :username, to: :user

    def created_at
        if (Time.zone.now - tweet.created_at) > 1.day
            tweet.created_at.strftime("%b %-d")
        else
            time_ago_in_words(tweet.created_at)
        end
    end

    def like_tweet_url
        if tweet_liked_by_current_user?
            tweet_like_path(tweet, current_user.likes.find_by(tweet: tweet))
        else
            tweet_likes_path(tweet)
        end
    end

    def like_heart_image
        if tweet_liked_by_current_user?
            "heart-filled.png"
        else
            "heart-empty.png"
        end
    end

    def turbo_data_method
        if tweet_liked_by_current_user?
            "delete"
        else
            "post"
        end
    end

    private
    
    # can't memoize the question marked version of this method
    def tweet_liked_by_current_user
        @tweet_liked_by_current_user ||= tweet.liked_users.include?(current_user)
    end
    alias_method :tweet_liked_by_current_user?,  :tweet_liked_by_current_user
end
