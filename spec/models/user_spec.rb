require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:tweets).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }

  describe "#set_display_name" do
    context "when display name is set" do
      it "does not change the display name" do
        user = build(:user, username: "tolasekelvin", display_name: "Tolase Kelvin Adegbite")
        user.save
        expect(user.reload.display_name).to eq("Tolase Kelvin Adegbite")
      end
    end

    context "when display name is not set" do
      it "humanizes the previous set username" do
        user = build(:user, username: "tolasekelvin", display_name: nil)
        user.save
        expect(user.reload.display_name).to eq("Tolasekelvin")
      end
    end
  end
end
