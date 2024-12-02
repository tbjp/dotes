require 'nokogiri'

class GenerateAudio
  def self.call(transcript)
    transcript = validate_ssml(transcript)

    client = Google::Cloud::TextToSpeech.text_to_speech do |config|
      config.credentials = JSON.parse(ENV.fetch("GOOGLE_JSON_KEY"))
    end

    response = client.synthesize_speech(
      input: { ssml: transcript },
      voice: { language_code: "en-GB", name: "en-GB-Neural2-B" },
      audio_config: { audio_encoding: "MP3",
                      speaking_rate: 0.85 }
    )

    return response.audio_content
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
