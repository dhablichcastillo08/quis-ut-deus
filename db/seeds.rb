# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Seeding default prayer habits..."

# Create a test user (development only)
if Rails.env.development?
  user = User.find_or_create_by!(email: "dev@quisutdeus.app") do |u|
    u.password = "password123"
    u.first_name = "Michael"
    u.last_name = "Guardian"
  end

  default_habits = [
    { name: "Morning Prayer", description: "Lauds — Morning offering", frequency: "daily" },
    { name: "Rosary", description: "Five decades of the Holy Rosary", frequency: "daily" },
    { name: "Mass", description: "Holy Mass attendance", frequency: "daily" },
    { name: "Divine Office", description: "Liturgy of the Hours", frequency: "daily" },
    { name: "Examen", description: "Ignatian Examen before bed", frequency: "daily" },
    { name: "Confession", description: "Sacrament of Reconciliation", frequency: "weekly" },
  ]

  default_habits.each do |habit|
    user.prayer_habits.find_or_create_by!(name: habit[:name]) do |h|
      h.description = habit[:description]
      h.frequency = habit[:frequency]
      h.active = true
    end
  end

  puts "Created #{user.prayer_habits.count} prayer habits for #{user.email}"
end