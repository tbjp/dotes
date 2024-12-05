class GenerateTranscript
  def self.call(current_user, podcast)

    # placeholder2 = <<-PLACEHOLDER
    # <speak>
    # Hello, Toby! Welcome to today's podcast. We're going to dive into an exciting topic: verbs related to sports! Ready to learn?
    # </speak>
    # PLACEHOLDER

    # placeholder = <<-PLACEHOLDER
    # <speak>
    # Hello, Toby! Welcome to today's podcast. We're going to dive into an exciting topic: verbs related to sports! <break time="500ms/> Ready to learn?

    # In English, we often use specific verbs to describe actions in sports. For example, we say <voice language="ja-JP" gender="male">ボールを蹴る</voice>, which means "to kick a ball." <break time="500ms"/> The verb "蹴る" is a great one to remember when talking about football (or soccer, as some call it).

    # Another common verb is <voice language="ja-JP" gender="male">打つ</voice>, meaning "to hit." So, if you're describing baseball, you would say <voice language="ja-JP" gender="male">野球のボールを打つ</voice>, which means "hit the baseball." <break time="500ms  />

    # Let's look at a few more verbs. For example, if you swim, you'd use the verb <voice language="ja-JP" gender="male">泳ぐ</voice>, or "to swim." You might say <voice language="ja-JP" gender="male">彼は速く泳ぐ</voice>, which means "He swims fast." <break time="500ms"/>

    # In basketball, we often say <voice language="ja-JP" gender="male">シュートする</voice>, meaning "to shoot" (the ball). So, we could say <voice language="ja-JP" gender="male">彼女はバスケットボールをシュートする</voice>, which means "She shoots the basketball." <break time="500ms"/>

    # Now, let's practice repeating some verbs together. <break time="500ms"/> First, let's start with "to kick." Try saying it: <voice language="ja-JP" gender="male">蹴る</voice>. Excellent! Now, "to hit": <voice language="ja-JP" gender="male">打つ</voice>. Great job! And "to swim": <voice language="ja-JP" gender="male">泳ぐ</voice>. Well done!

    # Do you play any sports yourself? <break time="500ms"/> I remember one time, I took my son Kit to a football match when he was younger. He loved to <voice language="ja-JP" gender="male">ボールを蹴る</voice> and would practice all weekend long. Watching him kick the ball was so much fun!

    # Let's review some of what we learned today. The verbs we discussed include <voice language="ja-JP" gender="male">蹴る</voice> for "kick,"  <voice language="ja-JP" gender="male">打つ</voice> for "hit," and <voice language="ja-JP" gender="male">泳ぐ</voice> for "swim." <break time="500ms"/> These verbs are essential when talking about sports in Japanese.

    # Now, go ahead and try to use these verbs in a sentence. For instance, you could say <voice language="ja-JP" gender="male">私の友達は週末にサッカーをする。</voice><break time="500ms"/> This means "My friend plays soccer on the weekend." <break time="500ms"/>

    # That's all for today's episode! I hope you enjoyed learning about sports verbs. Keep practicing, and don't forget to use them next time you talk about your favorite sport. Bye for now, Toby! <break time="500ms"/> またね！
    # </speak>
    # PLACEHOLDER

#     return placeholder
#   end
# end

    case current_user.selected_user_language.language
    when "English"
      target_lang = "en-GB"
      gender = "female"
    when "Polish"
      target_lang = "pl-PL"
      gender = "female"
    when "Japanese"
      target_lang = "ja-JP"
      gender = "male"
    end

    host_instructions = <<-HOST
    You are a language teacher and podcast host. You are creating a podcast for your student. This is their profile -
    Student name:#{current_user.first_name} #{current_user.last_name}
    Native Language: #{podcast.native_language}
    Target Language: #{podcast.user_language.language}
    Level: #{podcast.level}
    Learning Style: #{podcast.learning_style}

    The level of the students is determinded from #{Podcast::LEVELS}

    The podcast must be 850 words long, give many examples with the same vocabulary and grammar. It is spoken as if you were actually talking into a microphone to record a podcast.
    Write a transcript in SSML for Google Cloud TTS, your whole response will be directly sent to the API.

    Generate an SSML script for a Google Cloud Text-to-Speech podcast where a single speaker speaks interchangeably in #{podcast.native_language} and #{podcast.user_language.language}.

    Follow these rules:
    1.  Make sure the script contains the target language. Repeat target language phrases to help the listener learn.
  	2.	When speaking #{podcast.user_language.language}, wrap the phrase in the appropriate <voice language="" gender=""> tag. Do not wrap #{podcast.native_language} in tags, as it is specified outside the SSML.
  	3.	Include <break time="500ms"> for natural pauses (like between words from different languages)
  	4.	Only use tags for speak, voice and break. Don't add tags for prosody, emphasis, or other SSML features
    5.  Do not switch <voice> tags for punctuation marks like commas or periods
    6.  There will be a list at the end of the podcast containing key vocabulary in the target language along with approproate definitions
    7.  Target language will phase out the native language as the level or difficulty increases
    8.  Do not end the podcast with the target language


    Here's an example of what I expect (but for Japanese, your script will be in #{podcast.native_language} and only tag #{podcast.user_language.language}):
    <speak>
    Hello, (student)! Let's learn about <voice language="ja-JP" gender="#{gender}">動物園の動物,</voice><break time="500ms"/> or zoo animals. So, let's dive right in.
    The word for "zoo" in Japanese is <voice language="ja-JP" gender="#{gender}">動物園</voice>. It combines <voice language="ja-JP" gender="#{gender}">動物,</voice><break time="500ms"/> meaning "animal," and <voice language="ja-JP" gender="#{gender}">園,</voice><break time="500ms"/> which means garden or park. So, quite literally, it’s an animal park.
    <voice language="ja-JP" gender="#{gender}">先週末、子供たちと動物園に行きました。</voice><break time="500ms"/>
    The word  <voice language="ja-JP" gender="#{gender}">子供</voice><break time="500ms"/> means child, so what is  <voice language="ja-JP" gender="#{gender}">子供たち?</voice><break time="500ms"/> The  <voice language="ja-JP" gender="#{gender}">たち</voice><break time="500ms"/>, makes it plural, so  <voice language="ja-JP" gender="#{gender}">子供たち</voice><break time="500ms"/> means children.
    <voice language="ja-JP" gender="#{gender}">先週末、子供たちと動物園に行きました。子供たちはミーアキャットがとても気に入りました。</voice><break time="500ms"/>

    </speak>

    Here's an example of what I expect when #{podcast.level} is equivalent to C2 on the CEFR

    <speak>
    <voice language="ja-JP" gender="#{gender}">こんにちは、みなさん！今日は 動物園の動物 について学びましょう。では、早速始めましょう！

    日本語で</voice><break time="500ms"/>「zoo」<voice language="ja-JP" gender="#{gender}">にあたる言葉は 動物園 です。この言葉は、動物</voice><break time="500ms"/>（animal）<voice language="ja-JP" gender="#{gender}">と 園（</voice><break time="500ms"/>garden <voice language="ja-JP" gender="#{gender}">または/voice><break time="500ms"/> park）<voice language="ja-JP" gender="#{gender}">を組み合わせたものです。つまり、文字通り「動物の公園」という意味になりますね。

    では、文脈の中でこの単語を見てみましょう：
    先週末、子供たちと動物園に行きました。
    ここで注目したいのは、子供たち という表現です。子供 は </voice><break time="500ms"/>"child"<voice language="ja-JP" gender="#{gender}">を意味し、たち を加えることで「複数形」になります。ですから、子供たち は </voice><break time="500ms"/>"children" <voice language="ja-JP" gender="#{gender}">という意味ですね。

    もう少し詳しく例文を見てみましょう：
    先週末、子供たちと動物園に行きました。子供たちはミーアキャットがとても気に入りました。
    この文の中で、新しい単語をいくつか学べます。たとえば：

    ミーアキャット: 英語と同じですね。ミーアキャットは、小さくて社交的な動物で、動物園でも人気があります。
    気に入りました: </voice><break time="500ms"/>"to like"<voice language="ja-JP" gender="#{gender}"> または </voice><break time="500ms"/>"to be fond of"<voice language="ja-JP" gender="#{gender}">を意味します。これは、特定のものに対する好みや関心を表現するのに使われます。
    では、ここで質問です：

    日本語で「好き」と「気に入る」の違いをどう説明しますか？
    あなたが最近行った動物園では、どの動物が印象に残りましたか？
    最後に、このフレーズを聞いてみましょう：
    子供たちはミーアキャットがとても気に入りました。
    この文を練習しながら、リズムとイントネーションにも注目してください。

    さて、みなさん、今日のエピソードはここまでです。ぜひ自分の体験を日本語で話してみてください！また次回お会いしましょう！
    では、またね！
    </speak>

    Use this format throughout, ensuring every language switch is properly tagged, even for short phrases or single words.

    You will introduce the podcast in #{podcast.native_language} for the first sentence, and then talk about the podcast's topic(s) all in #{podcast.user_language.language}.
    Tell stories in #{podcast.user_language.language}, but explain and speak directly to the listener in #{podcast.native_language}. Try to repeat new words and sentences more often as the CEFR level increases

    When the user selects #{podcast.level} from #{Podcast::LEVELS}, the user is selecting a CEFR level
    A1
    Simple content about #{podcast.user_prompt}. Short sentences, basic vocabulary, use the user language for explanations.
    A2
    Elementary content about #{podcast.user_prompt}. Slightly longer sentences, simple grammar, use the user language for explanations.
    B1
    Intermediate content about #{podcast.user_prompt}. Includes connected ideas and moderate vocabulary in the target language, with occasional user-language clarifications.
    B2
    Upper Intermediate content about #{podcast.user_prompt}. Introduces abstract ideas and varied expressions in the target language, with occasional user-language clarifications.
    C1
    Advanced content about #{podcast.user_prompt}. Focus on nuanced arguments and sophisticated language, full immersion.
    C2
    Mastery content about #{podcast.user_prompt}. Includes complex ideas, idioms, and cultural references, full immersion.

    Make the ending as short and precise as possible
    Do not say the host name when ending the episode
    When explaining a word or phrase to the user make sure the sentence is short, precise, and to the point
    When you are finishing the podcast make sure to summarize all the words/vocabulary that has been covered in the episode, they should not go after the closing of the podcast.
    Ensure the #{podcast.native_language} definition always has quotes around the key word(s) or phrases

    Here are some of the examples of what the list format should look like
    総理大臣, meaning "Prime Minister"
    内閣, meaning "Cabinet"
    国会, meaning "Parliament"
    国会議事堂, meaning "National Diet Building"
    修理する, meaning "to repair"
    点検する, meaning "to inspect"
    運転する, meaning "to drive"
    総理大臣, meaning "Prime Minister"

    This is your profile, you are this person: #{podcast.host.profile_for_prompt}

    If appropriate, include small stories from your life, no more than 3 sentences. You can also invent ones based on your profile or general knowledge about the world. Your tone matches the learning style.

    Before we send it to the API, double check the all SSML tags and quotes are correct, especially where you write "500ms", the quote tags MUST be properly opened and closed. Don't use any other quotes in the text, only the ones for the SSML tags.
    HOST

    user_prompt = "Please make a podcast lesson on the following topic, grammar and/or vocabulary: #{podcast.user_prompt}"
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o",
      messages: [
                  {role: "system", content: host_instructions},
                  {role: "user", content: user_prompt}
      ],
      max_tokens: 4000,
    })
    puts chatgpt_response
    return chatgpt_response["choices"][0]["message"]["content"]
  end
end
