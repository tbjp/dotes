require 'nokogiri'

class GenerateAudio
  def self.call(transcript, user)
    transcript = validate_ssml(transcript)

    client = Google::Cloud::TextToSpeech.text_to_speech do |config|
      config.credentials = JSON.parse(ENV.fetch("GOOGLE_JSON_KEY"))
    end

    case user.selected_user_language.language
    when "English"
      native_lang = "ja-JP"
      voice = "ja-JP-Neural2-B"
    when "Polish"
      native_lang = "en-US"
      voice = "en-US-Wavenet-C"
    when "Japanese"
      native_lang = "en-GB"
      voice = "en-GB-Neural2-B"
    end
    puts "-----Generate Audio-----"
    puts "Native lang = #{native_lang}"
    puts "Voice = #{voice}"

    response = client.synthesize_speech(
      input: { ssml: transcript },
      voice: { language_code: native_lang, name: voice },
      audio_config: { audio_encoding: "MP3",
                      speaking_rate: 0.85 }
    )
    p response
    return response
  end

  def self.validate_ssml(ssml)
    doc = Nokogiri::XML(ssml)

    if doc.errors.any?
      puts "Invalid SSML: #{doc.errors.join(', ')}"
      return correct_break_tags(ssml)
    end
    return ssml
  end

  def self.correct_break_tags(ssml)
    # Regular expression to match <break> tags with time attributes
    break_tag_regex = /<break\s+time="?([^"]*?)"?\s*\/?>/

    # Replace any <break> tags with missing quotes
    ssml.gsub(break_tag_regex, '<break time="\1"/>')
  end

  private_class_method :validate_ssml, :correct_break_tags
end
