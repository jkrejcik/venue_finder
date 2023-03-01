# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'open-uri'

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
buildings = ["Hotel", "Restaurant", "Conference Center", "Social Club", "Country Club", "Exhibition Venue", "Business Center"]

3.times do
  venue = Venue.new
  venue.user = users.sample
  venue.name = Faker::Company.name
  venue.address = Faker::Address.full_address
  venue.building = buildings.sample
  venue.street = Faker::Address.street_address
  venue.city = Faker::Address.city
  venue.country = Faker::Address.country
  venue.zip = Faker::Address.zip
  venue.description = Faker::Lorem.paragraph
  venue.price = rand(50..998)
  venue.capacity = rand(200..5000)
  # Postgrest date format yyyy-mm-dd
  venue.available_start_date = Date.today

  # Random end date min. 15 - max.95 days in future
  venue.available_end_date = Date.next_day(rand(15..95))

  # Using regex to separate string from building type so it can be placed in http in right format
  # With one word building type (e.g. Hotel) there is no problem, problem is with two words (e.g. Social Club)
  # as format for unsplash must be fore case with 2 words (...random/?social
  match = /(\w+)\W?(\w+)?/.match(venue.building.downcase)

  # Adding 3 picture to each venue
  3.time do
    file = URI.open("https://source.unsplash.com/random/?#{match[1]}?#{match[2]}")
    venue.photos.attach(io: file, filename: venue.name)
  end

  venue.save
  puts "Venue #{venue.id} created with pictures"
end

# Booking creation
puts "Creating 1 Booking for user Jaro with Venue 1"

booking = Booking.new
booking.user = user3
# Can happen that he will book same place few times
booking.venue = Venue.find(1)
booking.booking_start_date = Date.today
booking.booking_end_date = Date.next_day(10)
booking.save
puts "Booking #{booking.id} created."

# Reviews creation
puts "Creating 4 reviews for user Jaro"
4.times do
  review = Review.new
  review.venue = Venue.find(1)
  review.title = Faker::Company.buzzword
  review.comment = Faker::Lorem.paragraph(sentence_count: 4)
  review.rating = rand(1..5)
  review.booking = booking
  review.save
  puts "Review #{review.id} created."
end

puts "Seeding completed"
