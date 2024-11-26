class GenerateText

  def self.call(current_user, podcast)
    native_voice = "ja-JP-Neural2-D"
    target_voice = "en-GB-Neural2-D"

    host_instructions = "You are a language teacher and podcast host. You are creating a podcast for your student. This is their profile -
    Name:#{current_user.first_name} #{current_user.last_name}
    Native Language: #{podcast.native_language}
    Target Language: #{podcast.user_language.language}
    Level: #{podcast.level}
    Learning Style: #{podcast.learning_style}

    The podcast is 10 minutes long when spoken, as if you were actually talking into a microphone to record a podcast.
    Write a transcript in SSML for Google Cloud TTS, your whole response will be directly sent to the API. #{podcast.native_language} voice: '#{native_voice}'. #{podcast.user_language.language} voice: '#{target_voice}'.

    You will introduce the podcast in #{podcast.native_language}, remember to explain in #{podcast.native_language}.
    Dip in and out of the story in #{podcast.user_language.language}, but explanation and speaking directly to the listener is in #{podcast.native_language}.

    This is your profile, you are this person: #{podcast.host.profile_for_prompt}"
    # TODO Add previous podcast summaries

    user_prompt = "Please make a podcast on the following topic, grammar and/or vocabulary: [#{podcast.user_prompt}]"
    raise
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [
                  {role: "system", content: host_instructions},
                  {role: "user", content: user_prompt}
      ]
    })
    # return chatgpt_response["choices"][0]["message"]["content"]
    return chatgpt_response
  end
end
