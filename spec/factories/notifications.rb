FactoryBot.define do
  factory :notification do
    user
    actor { create(:user) }
    verb { Notification::VERBS.sample }
  end
end
