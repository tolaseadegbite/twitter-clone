require "rails_helper"

RSpec.describe "Profile", type: :request do
    let(:user) { create(:user) }

    before { sign_in user }

    describe "GET Show" do
        it "suceeds" do
            get profile_path
            expect(response).to have_http_status(:success)
        end
    end

    describe "PUT update" do
        it "updates the profile" do
            expect do
                put profile_path, params: {
                    user: {
                        bio: "Some bio"
                    }
                }
            end.to change { user.bio }.from(nil).to("Some bio")
            expect(response).to redirect_to(profile_path)
        end
    end
end