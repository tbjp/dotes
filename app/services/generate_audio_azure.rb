require 'net/http'
require 'uri'
require 'json'

class GenerateAudio

  def self.call#(transcript)
    # return '/audios/placeholder.mp3' # skip API call for now
    key = ENV.fetch("AZURE_API_KEY")
    region = 'japaneast'

    uri = URI("https://#{region}.tts.speech.microsoft.com/cognitiveservices/v1")

    # SSML body for the TTS
    # ssml = transcript
#     ssml = '<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="en-GB">
#     <voice name="en-GB-OllieMultilingualNeural">
#       <lang xml:lang="en-GB">We look forward to working with you!</lang>
#       <lang xml:lang="es-MX">¡Esperamos trabajar con usted!</lang>
#       <lang xml:lang="ja-JP">私たちはあなたと一緒に仕事をするのを楽しみにしています！</lang>
#       <lang xml:lang="en-GB">The word,</lang>
#       <lang xml:lang="ja-JP">鴨,</lang>
#       <lang xml:lang="en-GB">means duck.</lang>
#     </voice>
# </speak>'

ssml = <<-SSML
<speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="ja-JP">
    <voice name="en-GB-OllieMultilingualNeural">
        We look forward to working with you!
        <lang xml:lang="es-MX">¡Esperamos trabajar con usted!</lang>
        <lang xml:lang="ja-JP">私たちはあなたと一緒に仕事をするのを楽しみにしています！</lang>
        The word,
        <lang xml:lang="ja-JP">
        <phoneme alphabet="ipa" ph="ka.mo">鴨</phoneme>,
        </lang>
        means duck. We'll explore the fascinating world of
        <lang xml:lang="ja-JP">
        <phoneme alphabet="ipa" ph="doː.bu.tsu.en no doː.bu.tsu">動物園の動物</phoneme>
          </lang>,
        or "zoo animals."
    </voice>
</speak>
SSML
    # ssml = <<-SSML
    # <speak version="1.0" xmlns="http://www.w3.org/2001/10/synthesis" xmlns:mstts="https://www.w3.org/2001/mstts" xml:lang="en-GB">
    # <voice name="en-GB-OllieMultilingualNeural">
    # <lang xml:lang="en-GB">
    #     Hello, Toby! Welcome to today's podcast, where we'll explore the fascinating world of</lang>
    #     <lang xml:lang="ja-JP">動物園の動物,</lang>
    #      or "zoo animals."
    #      </voice></speak>
    # SSML

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

    p response

    # Save the audio file
    File.binwrite("output8.mp3", response.body)
    puts "Audio saved as 'output.mp3'"
    return response.body
  end
end
