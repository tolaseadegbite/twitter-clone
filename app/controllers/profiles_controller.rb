class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
        @user = current_user
        @tweet_presenters = @user.tweets.map do |tweet|
            TweetPresenter.new(tweet: tweet, current_user: @user)
        end
        render "users/show"
    end

    def update
        @user = current_user
        if @user.update(user_params)
            respond_to do |format|
                # flash[:notice] = "Your profile has been updated"
                format.html { redirect_to profile_path }
                format.turbo_stream
            end
        else
            flash[:alert] = current_user.errors.full_messages.join(", ")
            redirect_to profile_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :display_name, :email, :bio, :profile_url, :location, :avatar)
    end
    
end