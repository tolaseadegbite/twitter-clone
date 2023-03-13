require 'rails_helper'

RSpec.describe "Tweets", type: :request do
    describe "GET show" do
        it "succeeds" do
            user = create(:user)
            sign_in user
            tweet = create(:tweet)
            get tweet_path(tweet)
            expect(response).to have_http_status(:success)
        end
    end
  describe "POST create" do
    context "when not logged in" do
        it "should redirect" do
            post tweets_path, params: {
                tweet: {
                    body: "A tweet body"
                }
            }
            expect(response).to have_http_status(:redirect)
        end
    end

    context "when logged in" do
        it "should create a new tweet" do
            user =create(:user)
            sign_in user
            expect do
                post tweets_path, params: {
                    tweet: {
                        body: "A tweet body"
                    }
                }
            end.to change { Tweet.count }.by(1)
            expect(response).to redirect_to(dashboard_url)
        end
    end
  end

end
