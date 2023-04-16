FactoryBot.define do
  factory :notification do
    user { nil }
    actor { nil }
    verb { "MyString" }
  end
end
