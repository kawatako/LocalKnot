FactoryBot.define do
  factory :question do
    user { nil }
    title { "MyString" }
    body { "MyText" }
    spot { nil }
  end
end
