class GenerateAudio
  def self.call(transcript)
    # audio = 'audio'
    # return audio # skip API call for now
    client = Google::Cloud::TextToSpeech.text_to_speech do |config|
      config.credentials = JSON.parse(ENV.fetch["GOOGLE_JSON_KEY"])
    end

    # mode = transcript.strip.start_with?("<speak>") ? "ssml" : "text"
    # more details on > https://cloud.google.com/text-to-speech/docs/ssml
    # if transcript is ssml your string should look like this:
    # <speak>
    #   Japanese Daycares
    #   <voice language="ja-JP">
    #     日本の保育園
    #   </voice>
    # </speak>

    # transcript = <<-SSML
    # <speak>
    # Hello, Toby! Welcome to today's podcast, where we'll explore the fascinating world of <voice language="ja-JP" gender="male">動物園の動物,</voice><break time="250ms"/> or "zoo animals." As always, I'll guide you through this with snippets from both English and Japanese. So, let's dive right in.
    # Did you know that the word for "zoo" in Japanese is <voice language="ja-JP" gender="male">動物園</voice>? It combines <voice language="ja-JP" gender="male">動物,</voice><break time="250ms"/> meaning "animal," and <voice language="ja-JP" gender="male">園,</voice><break time="250ms"/> which means "garden" or "park." So, quite literally, it’s an "animal park."
    # </speak>
    #  SSML

    response = client.synthesize_speech(
      input: { ssml: transcript },
      voice: { language_code: "en-GB", name: "en-GB-Neural2-B" },
      audio_config: { audio_encoding: "MP3",
                      speaking_rate: 0.85}
    )

    # audio_string = response.audio_content # base64 string format

    # audio_path = Rails.root.join("app", "assets", "audio", "output.mp3")
    # File.binwrite('output_google.mp3', response.audio_content) # creating audio_file

    return response.audio_content
  end
end
