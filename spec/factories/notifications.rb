FactoryBot.define do
  factory :notification do
    user { nil }
    post { nil }
    message { "MyString" }
    read { false }
  end
end
