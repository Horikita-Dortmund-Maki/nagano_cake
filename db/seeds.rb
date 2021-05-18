# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
   name: 'testtest',
   email: 'test@test.com',
   password: 'testtest'
  )
  
  

5.times do
     Customer.create(
        first_name = Faker::Japanese::Name.first_name,
        last_name = Faker::Japanese::Name.last_name,
        first_name = Faker::Japanese::Name.first_name,
        last_name = Faker::Japanese::Name.last_name,
        email: Faker::Internet.email,
        postcode: Faker::Address.postcode,  
        address: Faker::Address.city,
        password: Faker::Internet.password(min_length: 8) 
      )
end
