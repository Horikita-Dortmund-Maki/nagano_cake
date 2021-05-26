FactoryBot.define do
  factory :item do
    name{ Faker::Lorem.character(number:5) }
    introduction{ Faker::Lorem.character(number:30) }
    price{"500"}
    genre_id{"1"}
    image_id{"1"}
    is_active{"true"}
  end
end