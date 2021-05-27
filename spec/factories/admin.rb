FactoryBot.define do

  factory :admin do
    name { "test" }
    email {"tester@example.com"}
    # sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
  end
end
