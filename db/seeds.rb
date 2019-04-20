# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: "john@wearefutureproofs.com", name: "John P", password:              "123456789", password_confirmation: "123456789")

25.times do |n|
  email = "example-#{n+1}@example.com"
  password = "password1"
  User.create!(email: email, name: Faker::Name.name, password: password, password_confirmation: password)
end

Project.create!(name: Faker::App.name, description: Faker::Lorem.sentence(5), source: "http://github.com", user_id: 1, created_at: 2.weeks.ago)

Project.create!(name: Faker::App.name, description: Faker::Lorem.sentence(5), source: "http://github.com", user_id: 1)

Project.create!(name: Faker::App.name, description: Faker::Lorem.sentence(5), source: "http://github.com", user_id: 2)

Project.create!(name: Faker::App.name, description: Faker::Lorem.sentence(5), source: "http://github.com", user_id: 3)
