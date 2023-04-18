class LikesController < ApplicationController
     before_action :authenticate_user!
   
     def create
        @like = current_user.likes.create(tweet: tweet)
        if @like.user != tweet.user
          Notification.create(user: tweet.user, actor: current_user, verb: "liked-tweet", tweet: tweet)
        end
        respond_to do |format|
          format.html { redirect_to dashboard_url }
          format.turbo_stream
        end
     end

     def destroy
          @like = tweet.likes.find(params[:id])
          @like.destroy
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