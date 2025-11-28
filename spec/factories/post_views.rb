FactoryBot.define do
  factory :post_view do
    user { association :user }
    post { association :post }
  end
end
