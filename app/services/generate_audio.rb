require 'net/http'
require 'uri'
require 'json'

class GenerateAudio

  def self.call
    key = ENV.fetch("AZURE_API_KEY")
    region = 'japaneast'

    uri = URI("https://#{region}.tts.speech.microsoft.com/cognitiveservices/v1")

    # SSML body for the TTS
    # ssml = transcript
    ssml = '<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="en-GB">
    <voice name="en-GB-OllieMultilingualNeural">
        <lang xml:lang="es-MX">¡Esperamos trabajar con usted!</lang>
        <lang xml:lang="en-GB">We look forward to working with you!</lang>
        <lang xml:lang="ja-JP">私たちはあなたと一緒に仕事をするのを楽しみにしています！</lang>
        <lang xml:lang="en-GB">The word,</lang>
        <lang xml:lang="ja-JP">鴨,</lang>
        <lang xml:lang="en-GB">means duck.</lang>
    </voice>
</speak>'

    # Build the HTTP request headers
    headers = {
      "Ocp-Apim-Subscription-Key" => key,
      "Content-Type" => "application/ssml+xml",
      # "X-Microsoft-OutputFormat" => "audio-16khz-128kbitrate-mono-mp3",
      "X-Microsoft-OutputFormat" => "audio-48khz-96kbitrate-mono-mp3",
      # "X-Microsoft-OutputFormat" => "audio-48khz-192kbitrate-mono-mp3",
      "User-Agent" => "Ruby"
    }

    # Make the HTTP POST request
    response = Net::HTTP.post(uri, ssml, headers)

    # Save the audio file
    File.binwrite("output5.mp3", response.body)
    puts "Audio saved as 'output.mp3'"
    return response.body
  end
end

# def get_tmdb_data
#   url = URI("https://api.themoviedb.org/3/configuration")
#   http = Net::HTTP.new(url.host, url.port)
#   http.use_ssl = true


#   request = Net::HTTP::Get.new(url)
#   request["accept"] = 'application/json'
#   request["Authorization"] = "Bearer #{ENV['TMDB_TOKEN']}"

#   response = http.request(request)
#   puts response.read_body
#   raise
# end
