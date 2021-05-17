# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

Genre.create!(name: 'ジャンル')

10.times do |n|
  Item.create!(name: "test#{n + 1}品目", introduction:"test!#{n + 1}品目", price:"#{n + 1}00", is_active: true, image_id: File.open("./app/assets/images/image#{n + 1}.png"), genre_id: 1)
end

Admin.create!(
   name: 'testtest',
   email: 'test@test.com',
   password: 'testtest'
  )