require 'rails_helper'

RSpec.describe "Tweets", type: :request do
    describe "GET show" do
        let(:user) { create(:user) }
        let(:tweet) { create(:tweet) }

        before do
            sign_in user
            allow(ViewTweetJob).to receive(:perform_later)
        end

        it "succeeds" do
            get tweet_path(tweet)
            expect(response).to have_http_status(:success)
        end

        it "queues up ViewedTweetJob" do
            get tweet_path(tweet)
            expect(ViewTweetJob).to have_received(:perform_later).with(user: user, tweet: tweet)
        end

        # it "increments the view count if tweet has not been viewed" do
        #     expect { get tweet_path(tweet) }.to change { View.count }.by(1)
        # end

        # it "does not increment the view count if tweet has been viewed" do
        #     create(:view, user: user, tweet: tweet)
        #     expect { get tweet_path(tweet) }.not_to change { View.count }.by(1)
        # end
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

    describe "saving mentions" do
        let(:user) { create(:user) }
        context "when there are no mentions in the body of the tweet" do
            it "does not create any new mentions" do
                expect do
                    Tweet.create(user: user, body: "Hello world!")
                end.not_to change { Mention.count }
            end
            
        end

        context "when there are mentions in the tweet body" do
            it "should create new mentions" do
                user = User.create(email: "foo@bar.com", username: "foobar", password: "password")
                expect do
                    Tweet.create(user: user, body: "Hello @foobar")
                end.to change { Mention.count }.by(1) 
            end
        end
    end

end
