class BookmarksController < ApplicationController
    before_action :authenticate_user!

    def index
        @tweet_presenters = current_user.bookmarked_tweets.order(created_at: :desc).map do |tweet|
            TweetPresenter.new(tweet: tweet, current_user: @user)
        end
    end

    def create
        @bookmark = current_user.bookmarks.create(tweet: tweet)
        respond_to do |format|
            format.html { redirect_to dashboard_url }
            format.turbo_stream
        end
    end

    def destroy
        @bookmark = tweet.bookmarks.find(params[:id])
        @bookmark.destroy
        respond_to do |format|
            format.html { redirect_to dashboard_url }
            format.turbo_stream
        end
    end

    private

    def tweet
        @tweet ||= Tweet.find(params[:tweet_id])
    end
end