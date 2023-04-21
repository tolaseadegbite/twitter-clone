class ReplyTweetsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @reply_tweet = tweet.reply_tweets.create(tweet_params.merge(user: current_user))
        if current_user != tweet.user
            Notification.create(user: tweet.user, actor: @reply_tweet.user, verb: "replied-me", tweet: @reply_tweet)

            TweetActivity::RepliedJob.perform_later(actor: current_user, tweet: @reply_tweet)
        end
        if @reply_tweet.save
            respond_to do |format|
                format.html {redirect_to dashboard_url}
                format.turbo_stream
            end
        end
    end

    private

    def tweet_params
        params.require(:tweet).permit(:body)
    end

    def tweet
        @tweet ||= Tweet.find(params[:tweet_id])
    end
end