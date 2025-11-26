FactoryBot.define do
  factory :comment do
    body { "MyText" }
    user { nil }
    video { nil }
    parent_id { "" }
  end
end
