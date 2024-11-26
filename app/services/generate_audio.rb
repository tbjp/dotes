class GenerateAudio
  def self.call
  return "Disabled for now" # Disabled to stop accidental calls
  client = OpenAI::Client.new
  chatgpt_response = client.audio.speech(parameters: {
      model: "tts-1",
      input: "ご飯を3分の1(さんぶんのいち)くらい少なめにしてもらえますか？全部食べきれないので、無駄にしたくないんです。",
      voice: "alloy",
      response_format: "mp3", # Optional
      speed: 1.0, # Optional
    }
   )

  File.binwrite('demo2.mp3', chatgpt_response)

  puts "Audio file saved"
  end
end
