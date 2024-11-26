# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

lorum = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"

puts 'Cleaning DB users'
Podcast.delete_all
Host.delete_all
UserLanguage.delete_all
User.delete_all

# Create a user
user1 = User.new(email: "b.mikorski@gmail.com", first_name: "Bartek", last_name: "Mikorski", native_language: "English")
user1.password = 'secret'
user1.learning_style = 'casual'
user1.interests = 'donuts, eating, traveling, world of warcraft, witcher (video game), elden ring, warhammer'
user1.suggested_topics = ['Introduction with これ/それ/あれ” - Fun topic: favorite donuts',
 '“Basic は/が Particles” - Fun topic: favorite travel destinations',
  '“Simple Verbs in Present Tense” - Fun topic: World of Warcraft gameplay',
   '“Adjective Use (い/な)” - Fun topic: donuts vs. snacks']
user1.save


user2 = User.new(email: "jarodmiz2018@gmail.com", first_name: "Jarod", last_name: "Mizgalski", native_language: "English")
user2.password = 'secret'
user2.learning_style = 'serious'
user2.interests = ['donuts', 'vintage japanese cars', 'working out', 'studying japanese', 'sushi']
user2.suggested_topics = ['Introduction with これ/それ/あれ” - Fun topic: favorite donuts',
 '“Basic は/が Particles” - Fun topic: favorite travel destinations',
  '“Simple Verbs in Present Tense” - Fun topic: World of Warcraft gameplay',
   '“Adjective Use (い/な)” - Fun topic: donuts vs. snacks']
user2.save


user3 = User.new(email: "tobypalethorpe@gmail.com", first_name: "Toby", last_name: "Palethorpe", native_language: "English")
user3.password = 'secret'
user3.learning_style = 'balanced'
user3.interests = ['photography', 'UK dance music', 'anthropology', 'history', 'science', 'technology', 'japanese culture', 'thailand']
user3.suggested_topics = ['Introduction with これ/それ/あれ” - Fun topic: favorite donuts',
 '“Basic は/が Particles” - Fun topic: favorite travel destinations',
  '“Simple Verbs in Present Tense” - Fun topic: World of Warcraft gameplay',
   '“Adjective Use (い/な)” - Fun topic: donuts vs. snacks']
user3.save

puts 'Making hosts'

host1 = Host.create!(
first_name: "Charles",
last_name: "Beasley",
voice: "PH",
nationality: "British",
age: 64,
location: "Frome, Somerset, England, UK",
family: "He has a wife called Dorothea Beasly. People often call her Dorothy. He has a son named Kit and a daughter named Aletta. He also has a dog named Harry, who is very cute but overly energetic.",
work: "He used to work as a field recordist for wildlife and travel TV shows for various companies.",
likes: "He likes: lemon flavours, chocolate, spiced food like chai tea, nature, reading fantasy novels, music from local cultures, baking, walking his dog, playing video games from the 90s.",
dislikes: "Coriander herb",
hobbies: "Line drawing houses, baking, learning languages.",
stories: ["a"]
)

host2 = Host.create!(
first_name: "a",
last_name: "a",
voice: "a",
nationality: "a",
age: "a",
location: "a",
family: "a",
work: "a",
likes: "a",
dislikes: "a",
hobbies: "a",
stories: ["a"]
)

host3 = Host.create!(
first_name: "a",
last_name: "a",
voice: "a",
nationality: "a",
age: "a",
location: "a",
work: "a",
family: "a",
likes: "a",
dislikes: "a",
hobbies: "a",
stories: ["a"]
)

puts 'Making 3 users with 2 languages and 6 placeholder podcasts each for Japanese'

[user1, user2, user3].each do |user|
  user_language = UserLanguage.new(user: user, language: "Japanese", level: "Beginner")
  podcast = Podcast.new(title: "Introduction with これ/それ/あれ",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)
  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  podcast = Podcast.new(title: "Past tense with and stories from childhood",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)
  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  podcast = Podcast.new(title: "Conjugating verbs in the present tense and daily acitivities",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)
  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  podcast = Podcast.new(title: "Conjugating verbs casually and talking about your favorite foods",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)
  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  podcast = Podcast.new(title: "Vocabulary for visiting the town hall",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)
  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  podcast = Podcast.new(title: "Vocabulary for your first day at work",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)


  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  user_language.user = user
  user_language.save
  user.selected_user_language = user_language
end

[user1, user2, user3].each do |user|
  user_language = UserLanguage.new(user: user, language: "Polish", level: "Beginner")
  podcast = Podcast.new(title: "Introduction with polish things",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user.suggested_topics[0],
                              transcript: lorum)

  podcast.user_language = user_language
  podcast.host = Host.first
  user_language.user = user
  podcast.save
  user_language.save
end

puts 'Japanese language set as selected language for all users'
puts 'Seeding complete'
