class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @notifications = current_user.notifications.includes(:actor, :tweet).reverse
        # @notifications_in_presenter = current_user.notifications.tweets.includes(:actor, :tweet, :user).reverse.map do |tweet|
        #     TweetPresenter.new(tweet: tweet, current_user: user)
    end

    def delete_all
        @delete_all = current_user.notifications.destroy_all
        flash[:alert] = "Notifications cleared"
        redirect_to notifications_path, status: :see_other
    end
end