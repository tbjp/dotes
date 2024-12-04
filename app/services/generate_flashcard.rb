class GenerateSummary
  def self.call(podcast)

    summary_instructions = <<-FLASHCARD
    You will be generating flashcards based on a podcast about language, you will be using a transcript file to make the flashcards for that podcast.

    Follow these rules:
    1.	the flashcards will display all mentions of the target language
    2.  each individual flash card will only display an individual word or phrase of the target language
    3.	each flashcard will display the definition in the user's native language
    4.  Return a raw JSON with this schema but no extra formatting{ title: <title of podcast>, summary: <summary of podcast>}

    extract all phrases or words in the transcript that belong to #{podcast.user_language.language}
    ensure that all extracted phrases or words have a definition in the #{podcast.native_language}

    Here are some examples of what I expect for the target language:
    車
    電車
    政府
    ゴジラ
    Dzień dobry
    deszcz
    żywność
    晴れた日でした
    今週後半に勉強します
    do zobaczenia następnym razem
    Poszedłem na tor wyścigowy w zeszłym miesiącu

    Here's an example of what I expect for the definition in the user language:
    car
    train
    government
    godzilla
    good day
    rain
    food
    it was a sunny day
    i will study later this week
    see you next time
    I went to the race track last month

    Here are some of the examples of the template the target language and user language will make up
    - 総理大臣, for Prime Minister.
    - 内閣, for Cabinet.
    - 国会, for Parliament.
    - 国会議事堂, for National Diet Building.
    - 修理する, meaning "to repair"
    - 点検する, meaning "to inspect"
    - 運転する, meaning "to drive"

    # the json will be divided by target language and the back side will be all user language with in the quotes ""
    FLASHCARD

    user_prompt = "Please make flashcards based on all the #{podcast.user_language.language} used in the poscast, please inlcude the #{podcast.native_language} translation, #{podcast.transcript}"
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
        model: "gpt-4o-mini",
        messages: [
                    {role: "system", content: summary_instructions},
                    {role: "user", content: user_prompt}
                  ]
      })
    puts chatgpt_response
    return chatgpt_response["choices"][0]["message"]["content"]
  end
end
