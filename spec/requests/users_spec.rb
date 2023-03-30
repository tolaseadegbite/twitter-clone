require "rails_helper"

RSpec.describe "Users", type: :request do
    let(:user) { create(:user) }
    let(:user_2) { create(:user) }

    before { sign_in user }

    describe "GET show" do
        it "suceeds" do
          get user_path(user_2)
          expect(response).to have_http_status(:success)  
        end

        it "redirects to profile path if user is his/herself" do
          get user_path(user)
          expect(response).to redirect_to profile_path
        end
    end
end