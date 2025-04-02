# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data
User.destroy_all
Task.destroy_all

puts " Seeding data..."

# Create test users
users = [
  {
    email: "user1@example.com",
    password: "password"
  },
  {
    email: "user2@example.com",
    password: "password"
  },
  {
    email: "admin@example.com",
    password: "password"
  }
]

users.each do |user_data|
  User.create!(
    email: user_data[:email],
    password: user_data[:password]
  )
  puts "Created user: #{user_data[:email]}"
end

# Create tasks for each user
User.all.each do |user|
  # Some completed tasks
  3.times do |i|
    Task.create!(
      title: "Completed Task #{i + 1}",
      description: "This task was completed on time",
      due_date: Date.today - (i + 1).days,
      completed: true,
      user: user
    )
  end

  # Some pending tasks
  3.times do |i|
    Task.create!(
      title: "Pending Task #{i + 1}",
      description: "This task needs to be completed soon",
      due_date: Date.today + (i + 1).days,
      completed: false,
      user: user
    )
  end

  # Some overdue tasks
  2.times do |i|
    Task.create!(
      title: "Overdue Task #{i + 1}",
      description: "This task is past its due date",
      due_date: Date.today - (i + 2).days,
      completed: false,
      user: user
    )
  end
end

puts " Done seeding! Created:"
puts "- #{User.count} users"
puts "- #{Task.count} tasks"
