class GenerateSummary
  def self.call(podcast)

    summary_instructions = <<-SUMMARY
      You will be generating a title and summary for a podcast about language, you will be using a transcript file to make a title and summary for that podcast.

      Follow these rules:
      1.	the title will have no puncuation
      2.	the title will have a max of 40 characters
      3.  the summary will have puncuation
      4.  the summary will have a max of 80 characters
      5.  Return a raw JSON with this schema but no extra formatting{ title: <title of podcast>, summary: <summary of podcast>}
      6.  do not include the current language in the title of the podcast
      7.  include target langauge phrases in the summary

      Here are some examples of what I expect for the title:
      "Past tense stories"
      "Present tense verbs"
      "Past tense adjectives and sports"
      "particles and house tasks"
      "counters and animals"


      Here's an example of what I expect for the summary:
      "[host name] talks about conjugating verbs for your favorite foods using basic pronouns"
      "[host name] talks about past tense adjectives while discussing sports using basic adjectives "
      "[host name] discusses numbers and counters using animals as examples"
      "[host name] covers particles while dicussing basic tasks around the house"
      "[host name] chats about the time during a business trips"
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
    return chatgpt_response["choices"][0]["message"]["content"]
  end
end
