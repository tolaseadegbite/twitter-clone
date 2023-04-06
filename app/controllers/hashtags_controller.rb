class HashtagsController < ApplicationController
    before_action :authenticate_user!
    
    def index
        @hashtags = Hashtag.all.includes(:tweets)
    end

    def show
        @hashtag = Hashtag.find(params[:id])
    end
end