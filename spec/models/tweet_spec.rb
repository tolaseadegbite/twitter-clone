require 'rails_helper'

RSpec.describe Tweet, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:body) }
  it { should validate_length_of(:body).is_at_most(280) }
  it { should have_many(:likes).dependent(:destroy) }
  it { should have_many(:liked_users).through(:likes).source(:user) }
  it { should have_many(:bookmarks).dependent(:destroy) }
  it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }
  it { should have_many(:retweets).dependent(:destroy) }
  it { should have_many(:retweeted_users).through(:retweets).source(:user) }
  it { should have_many(:views) }
  it { should have_many(:viewed_users).through(:views).source(:user) }
  it { should belong_to(:parent_tweet).with_foreign_key(:parent_tweet_id).class_name("Tweet").inverse_of(:reply_tweets).optional }
  it { should have_many(:reply_tweets).with_foreign_key(:parent_tweet_id).class_name("Tweet") }
  it { should have_and_belong_to_many(:hashtags) }
  it { should have_many(:mentions).dependent(:destroy) }
  it { should have_many(:mentioned_users).through(:mentions) }

  describe "saving hashtags" do
    let(:user) { create(:user) }
    context "when there are no hashtags in the body" do
      it "does not create any hashtags" do
        expect do
          Tweet.create(user: user, body: "Mary had a little lamb")
        end.not_to change { Hashtag.count }
      end
    end
    context "when there are hashtags in the body" do
      it "creates hashtags" do
        expect do
          Tweet.create(user: user, body: "Mary has a #little #lamb")
        end.to change { Hashtag.count }.by(2)
      end

      it "creates hashtags assignned to the tweet" do
        tweet = Tweet.create(user: user, body: "My nickname is #Tolase and I am a #Rails developer")
        expect(tweet.hashtags.size).to eq(2)
      end
    end

    context "when there are duplicate hashtags in the body" do
      it "does not create extra hashtags if already in the database" do
        Hashtag.create(tag: "little")
        expect do
          Tweet.create(user: user, body: "Mary has a #new #little sister")
        end.to change { Hashtag.count }.by(1)
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

          it "creates notifications" do
            user = User.create(email: "foo@bar.com", username: "foobar", password: "password")
              expect do
                  Tweet.create(user: user, body: "Hello @foobar")
              end.to change { Notification.count }.by(1)
          end
      end
  end
end
