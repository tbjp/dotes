require 'stringio'

class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    transcript = GenerateTranscript.call(current_user, podcast)
    puts transcript
    audio_data = GenerateAudio.call(transcript)

    audio_io = StringIO.new(audio_data)
    audio_io.rewind

    podcast.audio.attach(io: audio_io, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg')
    return [transcript, audio_data]
  end
end
