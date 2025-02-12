FactoryBot.define do
  factory :answer do
    user { nil }
    question { nil }
    body { "MyText" }
  end
end
