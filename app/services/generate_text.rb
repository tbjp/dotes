class GenerateText
  def self.call
  client = OpenAI::Client.new
  chatgpt_response = client.chat(parameters: {
    model: "gpt-4o-mini",
    messages: [{ role: "user", content: "Give me a simple recipe for doughnuts with the ingredients match and white chocolate. Give me only the text of the recipe, without any of your own answer like 'Here is a simple recipe'."}]
  })
  # return chatgpt_response["choices"][0]["message"]["content"]
  return chatgpt_response
  end
end
