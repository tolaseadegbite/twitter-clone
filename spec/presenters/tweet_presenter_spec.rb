require 'rails_helper'

RSpec.describe TweetPresenter, type: :presenter do
  describe "created_at" do
    context "when 24 hours have passed" do
        before do
            travel_to Time.local(2008, 9, 3, 10, 5, 0)
        end

        after do
            travel_back
        end

        it "displays the shorten date format" do
            tweet = create(:tweet)
            tweet.update! created_at: 2.days.ago
            expect(TweetPresenter.new(tweet).created_at).to eq("Sep 1")
        end
    end

    context "before a full day has passed" do
        it "dislays how many hours have passed" do
            tweet = create(:tweet)
            tweet.update! created_at: 2.hours.ago
            expect(TweetPresenter.new(tweet).created_at).to eq("about 2 hours")
        end
    end
  end
end
