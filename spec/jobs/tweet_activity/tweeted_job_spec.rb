require 'rails_helper'

RSpec.describe TweetActivity::TweetedJob, type: :job do
  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }
  let(:tweet_user) { tweet.user }

  it "creates a new activity" do
    tweet_user.followers << user
    expect do
      described_class.new.perform(actor: tweet_user, tweet: tweet)
    end.to change { TweetActivity.count }.by(1)
  end
end
