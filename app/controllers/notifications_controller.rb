class NotificationsController < ApplicationController
    before_action :authenticate_user!

    def index
        @notifications = current_user.notifications.includes(:actor, :tweet).reverse
    end

    def delete_all
        @delete_all = current_user.notifications.destroy_all
        flash[:alert] = "Notifications cleared"
        redirect_to notifications_path, status: :see_other
    end
end