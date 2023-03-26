class ReplyTweetsController < ApplicationController
    before_action :authenticate_user!
    
    def create
        @tweet = tweet.reply_tweets.create(tweet_params.merge(user: current_user))
        if @tweet.save
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