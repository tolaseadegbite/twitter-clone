require 'rails_helper'

RSpec.describe "Usernames", type: :request do
    let(:user) { create(:user, username: nil) }
    before { sign_in user }

    describe "GET new" do
        it "should be successful" do
            get new_username_path
            expect(response).to have_http_status(:success)
        end
    end

    describe "PUT update" do
        context "valid params" do
            it "should update username" do
                expect do
                    put username_path(user), params: {
                        user: {
                            username: "foobar"
                        }
                    }
                end.to change { user.reload.username }.from(nil).to("foobar")
                expect(user.display_name).to eq("Foobar")
                expect(response).to redirect_to(dashboard_path)
            end
        end

        context "invalid params" do
            it "should redirect update" do
                expect do
                    put username_path(user), params: {
                        user: {
                            username: ""
                        }
                    }
                end.not_to change { user.reload.username}
                expect(response).to redirect_to(new_username_url)
            end
        end
    end
end
