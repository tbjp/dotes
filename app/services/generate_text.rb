class GenerateText
  def self.call(current_user, podcast)
    return "<speak>
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
  end

  def self.callDisabled(current_user, podcast)
    native_voice = "ja-JP-Neural2-D"
    target_voice = "en-GB-Neural2-D"

    host_instructions = "You are a language teacher and podcast host. You are creating a podcast for your student. This is their profile -
    Name:#{current_user.first_name} #{current_user.last_name}
    Native Language: #{podcast.native_language}
    Target Language: #{podcast.user_language.language}
    Level: #{podcast.level}
    Learning Style: #{podcast.learning_style}

    The podcast is 10 minutes long when spoken, as if you were actually talking into a microphone to record a podcast.
    Write a transcript in SSML for Google Cloud TTS, your whole response will be directly sent to the API. #{podcast.native_language} voice: '#{native_voice}'. #{podcast.user_language.language} voice: '#{target_voice}'

    Generate an SSML script for a Google Cloud Text-to-Speech podcast where a single speaker speaks interchangeably in English and Japanese. The speaker uses specific phrases or words from one language within sentences of the other language.

    Follow these rules:
  	1.	Use the <voice> tag to define the voice and language for every segment, including single words or phrases in a different language within a sentence.
  	2.	Use languageCode='en-GB' with name='en-GB-Neural2-D' for English and languageCode='ja-JP' with name='ja-JP-Neural2-D' for Japanese.
  	3.	When switching languages in the middle of a sentence, wrap the phrase in the appropriate <voice> tag.
  	4.	Include <break> tags for natural pauses (e.g., between sentences or after emphasis).
  	5.	Use appropriate SSML formatting for emphasis where needed.
    7.  Do not switch <voice> tags for punctuation marks like commas or periods.


    Here’s an example of what I expect:
    [<speak>
        <voice languageCode='en-GB' name='en-GB-Neural2-D'>
      In today's podcast, we’ll talk about the Japanese words
     <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>これ, それ, あれ</voice>.
      These mean 'this,' 'that,' and 'that over there.'
  </voice>
      <voice languageCode='en-GB' name='en-GB-Neural2-D'>
        One tip is to remember that the Japanese phrase
      </voice>
      <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>敬語</voice>
      <voice languageCode='en-GB' name='en-GB-Neural2-D'>
        is crucial for formal speech.
      </voice>
      <break time='500ms' />
      <voice languageCode='ja-JP' name='ja-JP-Neural2-D'>
        次に、日本語で考える練習をしたほうがいいですね。
      </voice>
      <voice languageCode='en-GB' name='en-GB-Neural2-D'>
        This means, 'You should practice thinking in Japanese next.'
      </voice>
    </speak>]
    Use this format throughout, ensuring every language switch is properly tagged, even for short phrases or single words.

    You will introduce the podcast in #{podcast.native_language}, remember to explain in #{podcast.native_language}.
    Dip in and out of the story in #{podcast.user_language.language}, but explanation and speaking directly to the listener is in #{podcast.native_language}.

    This is your profile, you are this person: #{podcast.host.profile_for_prompt}

    If appropriate, include stories from your life, you can also invent ones based on your profile or general knowledge about the world. Your tone matches the learning style."
    # TODO Add previous podcast summaries

    raise "Don't waste money!"

    user_prompt = "Please make a podcast lesson on the following topic, grammar and/or vocabulary: [#{podcast.user_prompt}]"
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [
                  {role: "system", content: host_instructions},
                  {role: "user", content: user_prompt}
      ]
    })
    # return chatgpt_response["choices"][0]["message"]["content"]
    raise
    return chatgpt_response
  end
end
