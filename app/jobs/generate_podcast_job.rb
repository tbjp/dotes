require 'stringio'

class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    p transcript = GenerateTranscript.call(current_user, podcast)

    audio_data = GenerateAudio.call(transcript)
    audio_io = StringIO.new(audio_data)
    audio_io.rewind

    podcast.audio.attach(io: audio_io, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg')

    full_sanitizer = Rails::HTML5::FullSanitizer.new
    sanitize_transcript = full_sanitizer.sanitize(transcript)
    podcast.update(transcript: sanitize_transcript)

    summary = GenerateSummary.call(podcast)
    full_sanitizer = Rails::HTML5::FullSanitizer.new
    sanitize_summary = full_sanitizer.sanitize(summary)
    p podcast.update(summary: sanitize_summary)

    return [transcript, audio_io]
  end
end
