FactoryBot.define do
  factory :profile do
    user { nil }
    user_name { "MyString" }
    introduction { "MyText" }
    birthdate { "2025-02-06" }
    gender { 1 }
    website { "MyString" }
  end
end
