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
end