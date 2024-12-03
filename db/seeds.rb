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
transcript = "<speak>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>
    Hello, Toby! Welcome to another episode of our language learning podcast, where we explore Japanese language in a fun and casual way. I'm your host, Charles Beasley. Today, we're diving into some essential Japanese vocabulary:
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>これ, それ, あれ</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>. These words help you point out or refer to objects and are quite handy.
    <break time='500ms' />
    Now let's get started!
    <break time='500ms' />
    To make it more interesting, we'll incorporate one of my favorite topics today: donuts!
    <break time='300ms' />
    Who doesn't love a good donut, right?
    <break time='500ms' />
    So, the Japanese word
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>これ</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>
    means 'this' and is used to refer to something close to the speaker. Imagine you're in a donut shop.
    <break time='300ms' />
    If you're pointing to, say, a delicious chocolate glazed donut right in front of you, you'd say:
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>
    これはチョコレートドーナツです
    </voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>, which means 'This is a chocolate donut.'
    <break time='500ms' />
    Moving on to
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>それ</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>, which translates to 'that,' used for objects closer to the listener. Let’s say you're talking with a friend who is closer to a matcha-flavored donut. You'd say:
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>
    それは抹茶ドーナツです
    </voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>, meaning 'That is a matcha donut.'
    <break time='500ms' />
    Now, let's talk about
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>あれ</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>, meaning 'that over there,' used for objects far from both the speaker and listener. Imagine seeing a custard-filled donut in the distance. You'd say:
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>
    あれはカスタードドーナツです
    </voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>, or 'That over there is a custard donut.'
    <break time='500ms' />
    Remember, these little words can be quite useful.
    <break time='300ms' />
    Speaking of which, I remember a lovely trip to Japan where I tried a donut shop with my wife, Dorothy. We wandered around a beautiful street with paper lanterns, and oh, the scents were heavenly! Dorothy pointed out a wonderful treat in the display case, and rightly so, she'd probably say
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>これがおいしい!</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>, meaning 'This is delicious!'
    <break time='500ms' />
    It's simple moments like these where
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>これ, それ, あれ</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'> come in handy for adding context to your adventures.
    <break time='500ms' />
    So, Toby, next time you're enjoying some scrumptious doughnuts, try using
    </voice>
    <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>これ, それ, あれ</voice>
    <voice languageCode='en-GB' name='en-GB-Neural2-D'>. It will surely impress your friends and make your language learning experience quite tasty.
    <break time='500ms' />
    That's all for today's episode. I hope you enjoyed our sweet language journey. Stay curious, Toby, until next time!
    </voice>
</speak>"

puts 'Cleaning DB users'
User.all.each do |user|
  user.update(selected_user_language: nil)
end
Podcast.destroy_all
Host.delete_all
UserLanguage.delete_all
User.delete_all

suggested_topics = ['Introduction with これ/それ/あれ” - Fun topic: favorite donuts',
'“Basic は/が Particles” - Fun topic: favorite travel destinations',
 '“Simple Verbs in Present Tense” - Fun topic: World of Warcraft gameplay',
  '“Adjective Use (い/な)” - Fun topic: donuts vs. snacks']

suggested_topics_pl = ['	Introducing yourself and basic greetings.',
	'Numbers, days of the week, and telling time.',
	'Ordering food and drinks at a café or restaurant.',
	'Asking for directions and basic navigation phrases.']

# Create a user
user1 = User.new(email: "b.mikorski@gmail.com", first_name: "Bartek", last_name: "Mikorski", native_language: "Polish")
user1.password = 'secret'
user1.learning_style = 'casual'
user1.interests = 'donuts, eating, traveling, world of warcraft, witcher (video game), elden ring, warhammer'
user1.save!


user2 = User.new(email: "jarodmiz2018@gmail.com", first_name: "Jarod", last_name: "Mizgalski", native_language: "English")
user2.password = 'secret'
user2.learning_style = 'serious'
user2.interests = ['donuts', 'vintage japanese cars', 'working out', 'studying japanese', 'sushi']
user2.save!


user3 = User.new(email: "tobypalethorpe@gmail.com", first_name: "Toby", last_name: "Palethorpe", native_language: "English")
user3.password = 'secret'
user3.learning_style = 'balanced'
user3.interests = ['photography', 'UK dance music', 'anthropology', 'history', 'science', 'technology', 'japanese culture', 'thailand']
user3.save!

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
stories: [
  "One misty morning, Charles took Harry for a walk along the river. Harry suddenly jumped into the water, barking at a duck. Charles laughed as he scrambled to pull the drenched and unapologetic dog out.",
  "During a summer picnic with his family, Charles attempted to bake bread over an open flame. The bread ended up more like a biscuit, but they all loved it and called it 'Beasley’s Bakes'.",
  "While recording bird sounds for a TV show in Scotland, Charles accidentally recorded his own sneeze, which somehow made it into the final episode. His family still teases him about it.",
  "One snowy Christmas Eve, Charles and Dorothea baked spiced biscuits together while singing old carols. Harry managed to steal one biscuit, but Charles let it slide with a chuckle.",
  "While line drawing a picturesque cottage, Charles realized he’d accidentally sketched a giant cat on the roof. Aletta loved it and made it into a greeting card.",
  "Charles once joined a local baking competition and won second place with his signature lemon loaf. He joked it was the spiced chai icing that secured the win.",
  "On a trip to India, Charles was mesmerized by a street musician playing a sitar. Inspired, he recorded the performance and blended it into an ambient track that became a family favorite.",
  "One evening, Kit introduced Charles to a retro video game from the 90s. Charles became so hooked he stayed up until 3 a.m. playing, and the next morning, Harry had to nudge him awake.",
  "While hiking with his family in Wales, Charles spotted a rare butterfly. He was so excited he spent the next hour trying to take the perfect photo while everyone else teased him.",
  "One rainy afternoon, Charles taught Aletta how to bake her favorite chocolate torte. They ended up covered in flour, and Harry had a field day licking up the mess."
]
)

host2 = Host.create!(
first_name: "Berta",
last_name: "Mikorska",
voice: "PH",
nationality: "Polish",
age: 30,
location: "Wroclaw, Poland",
family: "She has two younger sisters and a younger brother. His parents died in a terrible motorcycle incident when they were going to sign their divorce papers.",
work: "She is a software developer and a founder of a digital marketing startup.",
likes: "Pączki, coke zero, meat and pancakes.",
dislikes: "She doesn’t like coriander and winter (because she cannot ride her motorcycle during winter).",
hobbies: "He likes riding motorcycles, playing video games and boardgames.",
stories: ["I was cruising down the familiar roads on my motorcycle, the wind in my face, feeling that rush that only a ride like this could give me. The streets of Wrocław had an energy about them, even in the early morning, when they were still quiet. But as I took a corner a little too fast, I felt the engine sputter. Great. Another issue with the bike. I pulled over and inspected it, but of course, I had no tools. That’s when I saw him, an older man walking his dog. He offered to help, and we ended up chatting about bikes for nearly an hour. He reminded me a lot of my dad—minus the motorcycle obsession. It was a random encounter, but one I appreciated. Sometimes, the best rides aren’t the ones we plan, but the ones that happen when we least expect it.",
 "Winter in Wrocław sucks. I can’t ride my motorcycle, and it feels like the whole city slows down. To cope, I find comfort in the little things. Every year, I make a trip to my favorite bakery for a box of pączki. There’s something about biting into that soft, sugary dough filled with fruit preserves or chocolate that makes winter just a bit more bearable. Last year, I went with my brother and sisters, and we devoured a box of them in less than an hour. It's these small traditions that help me get through the tough months.",
"I hate winter. The snow, the cold—it all just gets in the way of riding. But one day, when the storm was at its peak, I decided to go out anyway. I suited up, braved the weather, and took my bike out for a quick spin around the city. It was chaotic, but there was something about riding in the snow that felt freeing. The world was quieter, the streets empty, and for a moment, it was just me and my bike. I couldn’t ride for long, but that brief escape was worth the frostbite."]
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
  user_language = UserLanguage.create(user: user, language: "Japanese", level: "Beginner", suggested_topics: suggested_topics)
  podcast = Podcast.new(title: "Introduction with これ/それ/あれ",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user_language.suggested_topics[0],
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
                              user_prompt: user_language.suggested_topics[0],
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
                              user_prompt: user_language.suggested_topics[0],
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
                              user_prompt: user_language.suggested_topics[0],
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
                              user_prompt: user_language.suggested_topics[0],
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
                              user_prompt: user_language.suggested_topics[0],
                              transcript: lorum)


  podcast.user_language = user_language
  podcast.host = Host.first
  podcast.save
  user_language.user = user
  user_language.save
  user_language = user_language
end

[user1, user2, user3].each do |user|
  user_language = UserLanguage.create(user: user, language: "Polish", level: "Beginner", suggested_topics: suggested_topics_pl)
  user_language_2 = UserLanguage.create(user: user, language: "English", level: "Beginner", suggested_topics: suggested_topics_pl)
  podcast = Podcast.new(title: "Introduction with polish things",
                             summary: "In this episode, we will learn how to use the basic Japanese pronouns これ/それ/あれ",
                             ai_summary: "This episode is an introduction to the basic Japanese pronouns これ/それ/あれ, you spoke about your favorite donuts",
                              native_language: "English",
                              level: user_language.level,
                              learning_style: user.learning_style,
                              user_prompt: user_language.suggested_topics[0],
                              transcript: lorum)

  podcast.user_language = user_language
  podcast.host = Host.second
  podcast.save
  user.selected_user_language = user_language
  user.save
end

puts 'Japanese language set as selected language for all users'
puts 'Seeding complete'
