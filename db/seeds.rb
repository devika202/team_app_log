# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# db/seeds.rb

admin_user = User.create!(
  email: 'devikaskrishnan2018@gmail.com',
  password: '123456789',
  role: 'admin',
  name: 'Devika',
  confirmed_at: Time.current
)

manager_user1 = User.create!(
  email: 'ananthuachu444@gmail.com',
  password: '123456789',
  role: 'manager',
  name: 'Ananthu',
  confirmed_at: Time.current
)

manager_user2 = User.create!(
  email: 'sruthi@gmail.com',
  password: '123456789',
  role: 'manager',
  name: 'Sruthi',
  confirmed_at: Time.current
)

regular_user2 = User.create!(
  email: 'diya@gmail.com',
  password: '123456789',
  role: 'member',
  name: 'Diya',
  confirmed_at: Time.current
)


puts 'Seed data for users created successfully!'
