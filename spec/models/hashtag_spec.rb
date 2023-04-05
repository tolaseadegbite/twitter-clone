require 'rails_helper'

RSpec.describe Hashtag, type: :model do
  it { should validate_presence_of(:tag) }
  it { should validate_uniqueness_of(:tag).case_insensitive }
  it { should have_and_belong_to_many :tweets }
end
