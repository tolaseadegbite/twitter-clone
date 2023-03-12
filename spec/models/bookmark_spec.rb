require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  it { should belong_to :user }
  it { should belong_to :tweet }
  # it { should have_many(:bookmarked_users).through(:bookmarks).source(:user) }
end
