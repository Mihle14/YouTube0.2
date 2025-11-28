FactoryBot.define do
  factory :comment do
    body { "Sample comment" }
    association :user
    association :post
  end
end

