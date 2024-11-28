class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(generate_text, generate_audio)
    # Do something later
  end
end
