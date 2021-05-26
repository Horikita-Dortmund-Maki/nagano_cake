FactoryBot.define do
  
  factory :admin do
    name { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end
