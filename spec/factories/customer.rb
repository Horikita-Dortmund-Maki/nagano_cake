FactoryBot.define do
  factory :customer do
    last_name {"test"}
    last_name_kana {"test"}
    first_name {"test"}
    first_name_kana {"test"}
    sequence(:email) {|n|"TEST#{n}@example.com"}
    password{"testcustomer"}
    postal_code {"1111111"}
    address {"tokyo"}
    telephone_number {"08011111111"}
  end
end