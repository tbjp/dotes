# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a user
user1 = User.new(email: "b.mikorski@gmail.com", first_name: "Bartek", last_name: "Mikorski", level: "A1", native_language: "English")
user1.password = 'secret'
user1.learning_style = 'casual'
user1.interests = 'donuts, eating, traveling, world of warcraft, witcher (video game), elden ring, warhammer'
user1.suggested_topics = ['Introduction with これ/それ/あれ” – Fun topic: favorite donuts',
 '“Basic は/が Particles” – Fun topic: favorite travel destinations',
  '“Simple Verbs in Present Tense” – Fun topic: World of Warcraft gameplay',
   '“Adjective Use (い/な)” – Fun topic: donuts vs. snacks']
user1.save


user2 = User.new(email: "jarodmiz2018@gmail.com", first_name: "Jarod", last_name: "Mizgalski", phone_number: "+48662402542")
user2.password = 'secret'
user2.learning_style = 'balanced'
user2.interests = 'donuts, eating, traveling, world of warcraft, witcher (video game), elden ring, warhammer'
user2.suggested_topics = ['Introduction with これ/それ/あれ” – Fun topic: favorite donuts',
 '“Basic は/が Particles” – Fun topic: favorite travel destinations',
  '“Simple Verbs in Present Tense” – Fun topic: World of Warcraft gameplay',
   '“Adjective Use (い/な)” – Fun topic: donuts vs. snacks']
user2.save
