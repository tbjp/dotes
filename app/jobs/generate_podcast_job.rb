require 'stringio'

class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    if current_user.email == 'jarodmiz2018@gmail.com'
      sleep 5
      podcast.transcript = Podcast.second_to_last.transcript
      podcast.summary = Podcast.second_to_last.summary
      podcast.title = Podcast.second_to_last.title
      podcast.save
      sleep 3
      podcast.update(status: 'failed')
      return
    end

    begin
    p transcript = GenerateTranscript.call(current_user, podcast)

    audio_data = GenerateAudio.call(transcript)
    audio_io = StringIO.new(audio_data)
    audio_io.rewind

    podcast.audio.attach(io: audio_io, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg')

    full_sanitizer = Rails::HTML5::FullSanitizer.new
    sanitize_transcript = full_sanitizer.sanitize(transcript)
    podcast.update(transcript: sanitize_transcript)
    puts ' !!!!!!!!!!!!!!! LOOKEEE HERERERERER Transcript added !!!!!!!!!!!!!!!!'
    puts podcast.transcript

    response = GenerateSummary.call(podcast)
    summary_title = JSON.parse(response)

    p podcast.update(summary: summary_title["summary"], title: summary_title["title"])
    rescue => e
      podcast.update(status: 'failed', error_message: e.message)
      # Optionally, log the error or notify someone
      Rails.logger.error("GeneratePodcastJob failed: #{e.message}")
    end
  end
end
