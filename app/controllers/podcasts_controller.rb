class PodcastsController < ApplicationController

  def index
    @podcasts = current_user.selected_user_language.podcasts
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

  def new
    @podcast = Podcast.new
    @user_language = current_user.selected_user_language
    # Toby's testing
    # GenerateAudio.call
    # GenerateText.call(current_user, Podcast.first)
    # GenerateAudio.call

  end

  def create
    strong_params = podcast_params
    suggested_topics = podcast_params[:suggested_topics]
    strong_params.delete(:suggested_topics)

    # Initialize a new Podcast with the remaining parameters
    @podcast = Podcast.new(strong_params)

    # Use suggested_topics to populate user_prompt if user_prompt is empty
    @podcast.user_prompt = suggested_topics if @podcast.user_prompt.blank? && suggested_topics.present?

    @podcast.user_language = current_user.selected_user_language # temporary
    @podcast.host = Host.first # temporary until we have select in form

    if @podcast.save
<<<<<<< HEAD
      transcript = GenerateTranscript.call(current_user, @podcast)
      audio = GenerateAudio.call(transcript)
      @podcast.transcript = transcript
      redirect_to podcast_path(@podcast)
    else
      @user_language = current_user.selected_user_language
      render :new, status: :unprocessable_entity
=======
      # transcript = GenerateText.call(current_user, @podcast) instead of calling the generatetext we call the job
      transcript = GeneratePodcastJob.perform_now(generate_text)
      # audio = GenerateAudio.call(transcript) also happen on the job too
      audio = GeneratePodcastJob.perform_now(generate_audio)
      full_sanitizer = Rails::HTML5::FullSanitizer.new
      @podcast.transcript = full_sanitizer.sanitize(transcript)
      if @podcast.save
        redirect_to podcast_path(@podcast)
      else
        @user_language = current_user.selected_user_language
        render :new, status: :unprocessable_entity
      end
>>>>>>> 7637eda8ea2e78a49b514da5da74a6f90c571f67
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.delete
  end

  private

  def podcast_params
    params.require(:podcast).permit(:title, :summary, :ai_summary, :native_language, :level, :learning_style, :user_prompt, :user_language_id, :suggested_topics)
  end
end
