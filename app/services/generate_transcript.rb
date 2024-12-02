class GenerateTranscript
  def self.call(current_user, podcast)

    # placeholder2 = <<-PLACEHOLDER
    # <speak>
    # Hello, Toby! Welcome to today's podcast. We're going to dive into an exciting topic: verbs related to sports! Ready to learn?
    # </speak>
    # PLACEHOLDER

#     placeholder = <<-PLACEHOLDER
#     <speak>
#     Hello, Toby! Welcome to today's podcast. We're going to dive into an exciting topic: verbs related to sports! <break time="500ms/> Ready to learn?

#     In English, we often use specific verbs to describe actions in sports. For example, we say <voice language="ja-JP" gender="male">ボールを蹴る</voice>, which means "to kick a ball." <break time="500ms"/> The verb "蹴る" is a great one to remember when talking about football (or soccer, as some call it).

#     Another common verb is <voice language="ja-JP" gender="male">打つ</voice>, meaning "to hit." So, if you're describing baseball, you would say <voice language="ja-JP" gender="male">野球のボールを打つ</voice>, which means "hit the baseball." <break time="500ms  />

#     Let's look at a few more verbs. For example, if you swim, you'd use the verb <voice language="ja-JP" gender="male">泳ぐ</voice>, or "to swim." You might say <voice language="ja-JP" gender="male">彼は速く泳ぐ</voice>, which means "He swims fast." <break time="500ms"/>

#     In basketball, we often say <voice language="ja-JP" gender="male">シュートする</voice>, meaning "to shoot" (the ball). So, we could say <voice language="ja-JP" gender="male">彼女はバスケットボールをシュートする</voice>, which means "She shoots the basketball." <break time="500ms"/>

#     Now, let's practice repeating some verbs together. <break time="500ms"/> First, let's start with "to kick." Try saying it: <voice language="ja-JP" gender="male">蹴る</voice>. Excellent! Now, "to hit": <voice language="ja-JP" gender="male">打つ</voice>. Great job! And "to swim": <voice language="ja-JP" gender="male">泳ぐ</voice>. Well done!

#     Do you play any sports yourself? <break time="500ms"/> I remember one time, I took my son Kit to a football match when he was younger. He loved to <voice language="ja-JP" gender="male">ボールを蹴る</voice> and would practice all weekend long. Watching him kick the ball was so much fun!

#     Let's review some of what we learned today. The verbs we discussed include <voice language="ja-JP" gender="male">蹴る</voice> for "kick,"  <voice language="ja-JP" gender="male">打つ</voice> for "hit," and <voice language="ja-JP" gender="male">泳ぐ</voice> for "swim." <break time="500ms"/> These verbs are essential when talking about sports in Japanese.

#     Now, go ahead and try to use these verbs in a sentence. For instance, you could say <voice language="ja-JP" gender="male">私の友達は週末にサッカーをする。</voice><break time="500ms"/> This means "My friend plays soccer on the weekend." <break time="500ms"/>

#     That's all for today's episode! I hope you enjoyed learning about sports verbs. Keep practicing, and don't forget to use them next time you talk about your favorite sport. Bye for now, Toby! <break time="500ms"/> またね！
#     </speak>
#     PLACEHOLDER

#     return placeholder
#   end
# end




    # native_voice = "en-GB-OllieMultilingualNeural"
    # target_voice = "en-GB-Neural2-D"

    host_instructions = <<-HOST
    You are a language teacher and podcast host. You are creating a podcast for your student. This is their profile -
    Name:#{current_user.first_name} #{current_user.last_name}
    Native Language: #{podcast.native_language}
    Target Language: #{podcast.user_language.language}
    Level: #{podcast.level}
    Learning Style: #{podcast.learning_style}

    The podcast is 10 minutes long when spoken, as if you were actually talking into a microphone to record a podcast.
    Write a transcript in SSML for Google Cloud TTS, your whole response will be directly sent to the API.

    Generate an SSML script for a Google Cloud Text-to-Speech podcast where a single speaker speaks interchangeably in English and Japanese. The speaker uses specific phrases or words from one language within sentences of the other language.

    Follow these rules:
    1. Make sure the script is at least 50% in the target language. Repeat words and sentences to help the listener learn.
  	2.	When switching languages in the middle of a sentence, wrap the phrase in the appropriate <voice language="" gender=""> tag
  	3.	Include <break time=""> for natural pauses (like between words from different languages)
  	4.	Use appropriate Google Cloud SSML formatting for emphasis where needed
    5.  Do not switch <voice> tags for punctuation marks like commas or periods


    Here’s an example of what I expect:
    <speak>
    Hello, Toby! Let's learn about <voice language="ja-JP" gender="male">動物園の動物,</voice><break time="500ms"/> or zoo animals. So, let's dive right in.
    The word for "zoo" in Japanese is <voice language="ja-JP" gender="male">動物園</voice>. It combines <voice language="ja-JP" gender="male">動物,</voice><break time="500ms"/> meaning "animal," and <voice language="ja-JP" gender="male">園,</voice><break time="500ms"/> which means garden or park. So, quite literally, it’s an animal park.
    <voice language="ja-JP" gender="male">先週末、子供たちと動物園に行きました。</voice><break time="500ms"/>
    The word  <voice language="ja-JP" gender="male">子供</voice><break time="500ms"/> means child, so what is  <voice language="ja-JP" gender="male">子供たち?</voice><break time="500ms"/> The  <voice language="ja-JP" gender="male">たち</voice><break time="500ms"/>, makes it plural, so  <voice language="ja-JP" gender="male">子供たち</voice><break time="500ms"/> means children.
    <voice language="ja-JP" gender="male">先週末、子供たちと動物園に行きました。子供たちはミーアキャットがとても気に入りました。</voice><break time="500ms"/>

    </speak>
    Use this format throughout, ensuring every language switch is properly tagged, even for short phrases or single words.

    You will introduce the podcast in #{podcast.native_language}, remember to explain in #{podcast.native_language}.
    Dip in and out of the story in #{podcast.user_language.language}, but explain and speak directly to the listener is in #{podcast.native_language}. Try to repeat new words and sentences often, then continue with another new sentence in the target language.

    This is your profile, you are this person: #{podcast.host.profile_for_prompt}

    If appropriate, include stories from your life, you can also invent ones based on your profile or general knowledge about the world. Your tone matches the learning style.

    Before we send it to the API, double check the all SSML tags and quotes are correct, especially where you write "500ms", the quote tags MUST be properly opened and closed. Don't use any other quotes in the text, only the ones for the SSML tags.
    HOST
    # TODO Add previous podcast summaries


    user_prompt = "Please make a podcast lesson on the following topic, grammar and/or vocabulary: #{podcast.user_prompt}"
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o",
      messages: [
                  {role: "system", content: host_instructions},
                  {role: "user", content: user_prompt}
      ]
    })
    puts chatgpt_response
    return chatgpt_response["choices"][0]["message"]["content"]
  end
end
