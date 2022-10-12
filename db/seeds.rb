# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a main sample user.
User.create!(name: "Admin User", email: "admin@admin.com",
            password: "foobar", password_confirmation: "foobar", admin: true)

# Generate a lots of additional users.
99.times do |n|
    name = Faker::Name.name
    email = "faker-#{n}@faker.com"
    password = "password"
    User.create!(name: name, email: email, password: password, password_confirmation: password)
end

# Generate microposts for a subset of users.
users = User.order(:created_at).take(6)
50.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each { |user| user.microposts.create!(content: content) }
end

# Generate following relationships.
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }