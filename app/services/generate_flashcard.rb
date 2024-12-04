class GenerateFlashcard
  def self.call(podcast)

    flashcard_instructions = <<-FLASHCARD
    You will be generating flashcards based on a podcast about language, you will be using a transcript file to make the flashcards for that podcast.

    Follow these rules:
    1.	the flashcards will display key vocabulary of the target language
    2.  each individual flashcard will only display an individual word or phrase of the target language
    3.	each individual flashcard will display the definition in the user's native language
    4.  if you make a deck of flashcard, it will not repeat the same vocabulary multiple times, only once, or a 1:1 ratio


    Here are some of the examples of the template the target language and user language will make up
    - 総理大臣, for Prime Minister.
    - 内閣, for Cabinet.
    - 国会, for Parliament.
    - 国会議事堂, for National Diet Building.
    - 修理する, meaning "to repair"
    - 点検する, meaning "to inspect"
    - 運転する, meaning "to drive"

    extract all key phrases or words in the transcript that belong to #{podcast.user_language.language} from the template above
    ensure that all extracted phrases or words have a definition in the #{podcast.native_language} from the template above
    FLASHCARD

    user_prompt = "Please make flashcards based on key vocabulary from #{podcast.user_language.language} used in the poscast, please inlcude the #{podcast.native_language} translation as a definition, #{podcast.transcript}. Your output should consist of a JSON file only."

    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
        model: "gpt-4o-mini",
        response_format: { type: "json_object" },
        messages: [
          {role: "system", content: flashcard_instructions},
          { role: "user", content: user_prompt}
        ],
        temperature: 0,
    })

    # p response.dig("choices", 0, "message", "content")

    response = chatgpt_response.dig("choices", 0, "message", "content")

    data_hash = JSON.parse(response)

    flashcards = data_hash["flashcards"]

    flashcards.each do |flashcard|
      flashcard_instance = Flashcard.new(target_vocab: flashcard["word"], native_definition: flashcard["definition"], podcast_id: podcast.id)
      flashcard_instance.save
    end
    podcast.broadcast_podcast
  end
end
