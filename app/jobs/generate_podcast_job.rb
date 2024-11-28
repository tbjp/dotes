class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    transcript = GenerateTranscript.call(current_user, podcast)
    puts transcript
    audio = GenerateAudio.call(transcript)
    return [transcript, audio]
  end
end
