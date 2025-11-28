FactoryBot.define do
  factory :like do
    like_type { "upvote" }
    user { association :user }
    post { association :post }
  end
end
