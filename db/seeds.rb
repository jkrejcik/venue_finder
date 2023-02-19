# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts "Cleaning database (Users/Venues/Bookings)"
# Once we add dependent: :destroy on User model we can skip cleaning Venue/Booking db

Booking.destroy_all
Venue.destroy_all
User.destroy_all

# Users created
user1 = User.create(first_name: "Jan", last_name: "Krejcik", email: "jan-krejcik@outlook.com", password: "password",
                    password_confirmation: "password")
user2 = User.create(first_name: "Ronan", last_name: "Boyle", email: "ronanoboyle.rob@gmail.com", password: "password",
                    password_confirmation: "password")
user3 = User.create(first_name: "Jaro", last_name: "Sidor", email: "jaroslav.sidor.ml@gmail.com", password: "password",
                    password_confirmation: "password")

puts "Creating Users..."
puts "Created #{user1.first_name} & #{user2.first_name} & #{user3.first_name} "

# Venues created (assigned randomly)
puts "Creating Venues"

# For test purposes just first 2 users have venues assigened
users = [user1, user2]

9.times do
  venue = Venue.new
  venue.user = users.sample

  venue.name = Faker::Company.name
  venue.address = Faker::Address.full_address
  venue.description = Faker::Company.catch_phrase
  venue.price = rand(50..998)
  venue.capacity = rand(200..5000)
  # Postgrest date format yyyy-mm-dd
  venue.available_start_date = "2023-02-18"

  # Radnom end date made simple without covering all options
  rand_month = rand(3..9)
  rand_day = rand(10..30)
  venue.available_end_date = "2023-0#{rand_month}-#{rand_day}"
  venue.save
  puts "Venue #{venue.id} created."
end

# Bookings created
puts "Creating Bookings"

4.times do
  booking = Booking.new

  # All bookings are created by Jaro
  booking.user = user3
  # Can happen that he will book same place few times
  booking.venue = Venue.find(rand(1..9))
  booking.save
  puts "Booking #{booking.id} created."
end

puts "Seeding completed"
