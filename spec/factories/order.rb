FactoryBot define do
  factory :order do
    customer_id{"1"}
    postal_code{Faker::Number.number(digits:7) }
    address{Faker::Lorem.character(number:20) }
    name{Faker::Lorem.character(number:4) }
    shopping_cost{"800"}
    total_payment{Faker::Number.number(digits:4)}
    payment_method{"0"}
    status{"0"}
  end
end
