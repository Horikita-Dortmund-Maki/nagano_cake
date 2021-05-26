FactoryBot define do
  factory :send_address do
    customer_id{"1"}
    postal_code{ Faker::Number.number(digits:7) }
    address{ Faker::Lorem.character(number:20) }
    name{ Faker::Lorem.character(number:4) }
  end
end