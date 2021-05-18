# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:

# ジャンル追加
Genre.create!(name: 'ジャンル')

# 商品追加
10.times do |n|
  Item.create!(name: "test#{n + 1}品目", introduction:"test!#{n + 1}品目", price:"#{n + 1}00", is_active: true, image: File.open("./app/assets/images/image#{n + 1}.png"), genre_id: 1)
end

# Item.create!(name: "test品目", introduction:"test品目", price:"11100", is_active: true, image: File.open("./app/assets/images/image1.png"), genre_id: 1)



Admin.create!(
  name: 'test',
  email: 'test@test.com',
  password: 'testtest'
  )
