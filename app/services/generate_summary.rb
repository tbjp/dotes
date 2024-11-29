class GenerateSummary
  def self.call(podcast)

    summary_instructions = <<-SUMMARY
      You will be generating a title and summary for a podcast about language, you will be using a transcript file to make a title and summary for that podcast.

      Follow these rules:
      1.	delimit the title and summary using XML tags
      2.	the title will have no puncuation
      3.	the title will have a max of 40 characters
      4.  the summary will only have commas for puncuation
      5.  the summary will have a max of 80 characters
      6.  Between the title and summary and a new line

      Here are some examples of what I expect for the title:
      "Past tense stories"
      "Present tense verbs"
      "Past tense adjectives and sports"


      Here's an example of what I expect for the summary:
      "In this episode, [host name] will talk about conjugating verbs for your favorite foods using basic Japanese pronouns これ/それ/あれ"
      "In this episode, [host name] will talk about adding past tense adjectives while discussing sports using basic Japanese adjectives おおきい/ちいさい/たかい/ひくい"
    SUMMARY

    user_prompt = "Please make a title and summary for the poscast, please inlcude the host's name: #{podcast.host.first_name}, #{podcast.transcript}"
    client = OpenAI::Client.new
    chatgpt_response = client.chat(parameters: {
      model: "gpt-4o-mini",
      messages: [
                  {role: "system", content: summary_instructions},
                  {role: "user", content: user_prompt}
                ]
    })
    puts chatgpt_response
    raise
    return chatgpt_response["choices"][0]["message"]["content"]
  end
end
