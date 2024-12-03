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

    # begin
    p transcript = GenerateTranscript.call(current_user, podcast)

    audio_response = GenerateAudio.call(transcript, current_user)
    if audio_response.audio_content.nil?
      podcast.update(status: 'failed')
      return
    else
      audio_io = StringIO.new(audio_response.audio_content)
      audio_io.rewind
    end

    podcast.audio.attach(io: audio_io, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg')

    doc = Loofah.html5_document(transcript)
    scrubbed_doc = doc.text(encode_special_chars: false)
    podcast.update(transcript: scrubbed_doc)

    response = GenerateSummary.call(podcast)
    summary_title = JSON.parse(response)

    podcast.update(summary: summary_title["summary"], title: summary_title["title"])
    podcast.errors.full_messages.each do |message|
      puts message
    end
  end
end
