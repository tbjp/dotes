class GenerateTranscript
#   def self.call(current_user, podcast)
#     placeholder = <<-PLACEHOLDER
# <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="en-GB">
#     <voice name="en-GB-OllieMultilingualNeural">
#         <lang xml:lang="es-MX">¡Esperamos trabajar con usted!</lang>
#         <lang xml:lang="en-GB">We look forward to working with you!</lang>
#         <lang xml:lang="ja-JP">私たちはあなたと一緒に仕事をするのを楽しみにしています！</lang>
#         <lang xml:lang="en-GB">The word,</lang>
#         <lang xml:lang="ja-JP">鴨,</lang>
#         <lang xml:lang="en-GB">means duck.</lang>
#     </voice>
# </speak>
#     PLACEHOLDER
#     return placeholder
#   end # placeholder

  def self.call(current_user, podcast)
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
  	2.	When switching languages in the middle of a sentence, wrap the phrase in the appropriate <voice language="" gender=""> tag
  	3.	Include <break time=""> for natural pauses (like between words from different languages)
  	4.	Use appropriate Google Cloud SSML formatting for emphasis where needed
    5.  Do not switch <voice> tags for punctuation marks like commas or periods


    Here’s an example of what I expect:
    <speak>
    Hello, Toby! Let's learn about <voice language="ja-JP" gender="male">動物園の動物,</voice><break time="500ms"/> or "zoo animals." So, let's dive right in.
    The word for "zoo" in Japanese is <voice language="ja-JP" gender="male">動物園</voice>. It combines <voice language="ja-JP" gender="male">動物,</voice><break time="500ms"/> meaning "animal," and <voice language="ja-JP" gender="male">園,</voice><break time="500ms"/> which means "garden" or "park." So, quite literally, it’s an "animal park."
    <voice language="ja-JP" gender="male">先週末、子供たちと動物園に行きました。</voice><break time="500ms"/>
    The word  <voice language="ja-JP" gender="male">子供</voice><break time="500ms"/> means child, so what is  <voice language="ja-JP" gender="male">子供たち?</voice><break time="500ms"/> The  <voice language="ja-JP" gender="male">たち</voice><break time="500ms"/>, makes it plural, so  <voice language="ja-JP" gender="male">子供たち</voice><break time="500ms"/> means children.
    <voice language="ja-JP" gender="male">先週末、子供たちと動物園に行きました。子供たちはミーアキャットがとても気に入りました。</voice><break time="500ms"/>

    </speak>
    Use this format throughout, ensuring every language switch is properly tagged, even for short phrases or single words.

    You will introduce the podcast in #{podcast.native_language}, remember to explain in #{podcast.native_language}.
    Dip in and out of the story in #{podcast.user_language.language}, but explain and speak directly to the listener is in #{podcast.native_language}. Try to repeat new words and sentences often, then continue with another new sentence in the target language.

    This is your profile, you are this person: #{podcast.host.profile_for_prompt}

    If appropriate, include stories from your life, you can also invent ones based on your profile or general knowledge about the world. Your tone matches the learning style.

    Before we send it to the API, double check the all SSML tags and quotes are correct, so the TTS engine rejects the script.
    HOST
    # TODO Add previous podcast summaries

    # raise "Don't waste money!"

    user_prompt = "Please make a podcast lesson on the following topic, grammar and/or vocabulary: #{podcast.user_prompt}"
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [
                  {role: "system", content: host_instructions},
                  {role: "user", content: user_prompt}
      ]
    })
    puts chatgpt_response
    return chatgpt_response["choices"][0]["message"]["content"]
    # raise
    # return chatgpt_response
  end
end
