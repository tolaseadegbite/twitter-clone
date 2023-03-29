class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
        
    end

    def update
        if current_user.update(user_params)
            flash[:notice] = "Your profile has been updated"
            redirect_to profile_path
        else
            flash[:alert] = current_user.errors.full_messages.join(", ")
            redirect_to profile_path
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :display_name, :email, :bio, :url, :location)
    end
    
end