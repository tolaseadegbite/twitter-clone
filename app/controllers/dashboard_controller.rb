class DashboardController < ApplicationController
    before_action :authenticate_user!
    
    def index
        # @tweets = Tweet.includes(:liked_users, :bookmarked_users, :retweeted_users, :likes, :retweets).order(created_at: :desc).map do |tweet| 
        #     TweetPresenter.new(tweet: tweet, current_user: current_user)
        # end

        following_users = current_user.following_users
        @tweets = Tweet.includes(:liked_users, :bookmarked_users, :retweeted_users, :likes, :retweets).where(user: following_users).order(created_at: :desc).map do |tweet| 
            TweetPresenter.new(tweet: tweet, current_user: current_user)
        end
    end
end