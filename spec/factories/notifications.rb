FactoryBot.define do
  factory :notification do
    message { Faker::Lorem.sentence }
    read { false }
    user { association :user }
    post { association :post }
  end
end
