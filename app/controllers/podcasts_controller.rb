class PodcastsController < ApplicationController
  def index
    if current_user.selected_user_language.podcasts.empty?
      redirect_to new_podcast_path
    else
      @podcasts = current_user.selected_user_language.podcasts.order(created_at: :desc)
    end
  end

  def show
    @podcast = Podcast.find(params[:id])
    @host = @podcast.host
    @flashcard = @podcast.incomplete_flashcard
  end

  def new
    @podcast = Podcast.new
    unless current_user.selected_user_language.podcasts.empty?
      last_podcast = current_user.selected_user_language.podcasts.last
      if last_podcast.present? && last_podcast.status == 'failed'
        @podcast = last_podcast.dup
        last_podcast.delete
      end
    end

    @user_language = current_user.selected_user_language
  end

  def create
    @podcast.update(status: 'new') if @podcast.present?
    strong_params = podcast_params
    suggested_topics = podcast_params[:suggested_topics]
    strong_params.delete(:suggested_topics)

    # Initialize a new Podcast with the remaining parameters
    @podcast = Podcast.new(strong_params) unless @podcast.present?


    # Use suggested_topics to populate user_prompt if user_prompt is empty
    @podcast.user_prompt = suggested_topics if @podcast.user_prompt.blank? && suggested_topics.present?

    @podcast.user_language = current_user.selected_user_language
    @podcast.native_language = current_user.native_language

    if current_user.selected_user_language.language == "Polish"
      @podcast.host = Host.second # temporary until we have select in form
    else
      @podcast.host = Host.first
    end


    if @podcast.save
      # transcript = GenerateText.call(current_user, @podcast) instead of calling the generatetext we call the job
      GeneratePodcastJob.perform_later(current_user, @podcast)
      redirect_to podcast_path(@podcast)
    else
      @user_language = current_user.selected_user_language
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.delete
    redirect_to podcasts_path
  end

  def flashcard_reset
    @podcast = Podcast.find(params[:id])
    @podcast.flashcards.update_all(correct: false)
    redirect_to podcast_path(@podcast)
  end

  private

  def podcast_params
    params.require(:podcast).permit(:title, :summary, :ai_summary, :native_language, :level, :learning_style, :user_prompt, :user_language_id, :suggested_topics)
  end
end
