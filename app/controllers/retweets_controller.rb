class RetweetsController < ApplicationController
    before_action :authenticate_user!

    def create
        @retweet = current_user.retweets.create(tweet: tweet)
        if @retweet.user != tweet.user
            Notification.create(user: tweet.user, actor: @retweet.user, tweet: tweet, verb: "retweeted-tweet")
        end
        respond_to do |format|
            format.html { redirect_to dashboard_url }
            format.turbo_stream
        end
    end

    def destroy
        @retweet = tweet.retweets.find(params[:id])
        @retweet.destroy
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