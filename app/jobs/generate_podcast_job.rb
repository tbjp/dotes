require 'stringio'
# require 'streamio-ffmpeg'

class GeneratePodcastJob < ApplicationJob
  queue_as :default

  def perform(current_user, podcast)
    # This section is for testing or demo mode and skips the API calls
    if current_user.email == 'jarodmiz2018@gmail.com' || current_user.id == 1

      unless User.find_by(email: 'tjp@duck.com')
        podcast.update(status: 'failed')
        return
      end

      # find a random podcast from the user with email
      sample = User.find_by(email: 'tjp@duck.com').podcasts.sample
      # sample = Podcast.find(313)
      podcast.user_language = current_user.selected_user_language
      podcast.level = sample.level
      podcast.user_prompt = sample.user_prompt
      podcast.audio.attach(sample.audio.blob) if sample.audio.attached?
      podcast.duration = sample.duration
      sleep 2
      podcast.transcript = sample.transcript
      podcast.save
      podcast.broadcast_podcast
      sleep 1
      podcast.title = sample.title
      podcast.summary = sample.summary
      podcast.ai_summary = sample.ai_summary
      podcast.save
      podcast.broadcast_podcast
      sleep 1
      podcast.broadcast_audio

      flashcards = sample.flashcards
      flashcards.each do |flashcard|
        flashcard_instance = Flashcard.new(target_vocab: flashcard.target_vocab, native_definition: flashcard.native_definition, podcast_id: podcast.id)
        flashcard_instance.save
      end

      # podcast.transcript = Podcast.second_to_last.transcript
      # podcast.summary = Podcast.second_to_last.summary
      # podcast.title = Podcast.second_to_last.title
      sleep 5
      # podcast.update(status: 'failed')
      podcast.broadcast_podcast
      return
    end

    # Begin real API calls
    p transcript = GenerateTranscript.call(current_user, podcast)

    audio_response = GenerateAudio.call(transcript, current_user)
    if audio_response.audio_content.nil?
      podcast.update(status: 'failed')
      return
    else
      audio_io = StringIO.new(audio_response.audio_content)
      audio_io.rewind
    end

    blob = podcast.audio.attach(io: audio_io, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg')
    blob.analyze
    podcast.duration = blob.metadata[:duration].to_i
    podcast.save
    podcast.broadcast_audio


    doc = Nokogiri::HTML.fragment(transcript)

    doc.css('voice').each do |voice_tag|
      span_tag = Nokogiri::XML::Node.new('span', doc)
      span_tag['class'] = 'target_language_text'
      span_tag.content = voice_tag.content
      voice_tag.replace(span_tag)
    end

    puts "--Transcript before scrubbing--"
    puts doc.to_html

    scrubbed_doc = Loofah.fragment(doc.to_html).scrub!(:strip).scrub!(:prune).to_html
    puts "--Transcript after scrubbing--"
    puts scrubbed_doc

    podcast.update(transcript: scrubbed_doc)
    podcast.broadcast_podcast

    response = GenerateSummary.call(podcast)
    summary_title = JSON.parse(response)

    podcast.update(summary: summary_title["summary"].capitalize, title: summary_title["title"].capitalize)
    podcast.broadcast_podcast

    GenerateFlashcard.call(podcast)

    podcast.errors.full_messages.each do |message|
      puts message
    end
  end
end
