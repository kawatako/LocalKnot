FactoryBot.define do
  factory :blog do
    title { "MyString" }
    body { "MyText" }
    user { nil }
    category { nil }
    spot { nil }
  end
end
