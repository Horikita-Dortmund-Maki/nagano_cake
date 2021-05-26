FactoryBot.define do
  factory :customer do
    last_name { Faker::Lorem.character(number:4) }
    last_name_kana { Faker::Lorem.character(number:4) }
    first_name { Faker::Lorem.character(number:4) }
    first_name_kana { Faker::Lorem.character(number:4) }
    sequence(:email) {|n|"TEST#{n}@example.com" }
    password{ Faker::Lorem.character(number:6) }
    postal_code { Faker::Number.number(digits: 7) }
    address { Faker::Lorem.character(number:20) }
    telephone_number { Faker::Number.leading_zero_number(digits: 11) }
  end
end