class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    transcript = GenerateTranscript.call(current_user, podcast)
    puts transcript
    audio = GenerateAudio.call(transcript)
    podcast.audio.attach(io: audio, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg')
    raise
    return [transcript, audio]
  end
end
