class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    transcript = GenerateTranscript.call(current_user, podcast)
    puts transcript
    full_sanitizer = Rails::HTML5::FullSanitizer.new
    sanitize_transcript = full_sanitizer.sanitize(transcript)
    podcast.update(transcript: sanitize_transcript)

    summary = GenerateSummary.call(podcast)
    puts summary
    full_sanitizer = Rails::HTML5::FullSanitizer.new
    sanitize_summary = full_sanitizer.sanitize(summary)
    podcast.update(summary: sanitize_summary)

    audio = GenerateAudio.call(transcript)
    return [transcript, audio]
  end
end
