require 'stringio'
# require 'streamio-ffmpeg'

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

    podcast.audio.attach(io: audio_io, filename: 'podcast_audio.mp3', content_type: 'audio/mpeg', image_metadata: true)

    # if podcast.audio.attached?
    #   Tempfile.create(['podcast_audio', '.mp3']) do |tempfile|
    #     tempfile.binmode
    #     tempfile.write(audio_response)
    #     tempfile.rewind

    #     ffmpeg = FFMPEG::Movie.new(tempfile.path)
    #     puts "Duration: #{ffmpeg.duration}"
    #     podcast.duration = ffmpeg.duration.to_i
    #     puts "Duration: #{ffmpeg.duration.to_i}"
    #     podcast.save!
    #   end
    # end

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
