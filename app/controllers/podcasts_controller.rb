class PodcastsController < ApplicationController

  def index
    @podcasts = current_user.selected_user_language.podcasts.order(created_at: :desc)
  end

  def show
    @podcast = Podcast.find(params[:id])
    @host = @podcast.host
  end

  def new
    @podcast = Podcast.new
    @user_language = current_user.selected_user_language
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
      # transcript = GenerateText.call(current_user, @podcast) instead of calling the generatetext we call the job
      GeneratePodcastJob.perform_later(current_user, @podcast)
      if @podcast.save
        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.append(:podcast, partial: "podcasts/audio",
            target: "podcast",
            locals: { podcast: @podcast })
          end
          format.html { redirect_to podcast_path(@podcast) }
        end
      else
        render "podcasts/show", status: :unprocessable_entity
      end
    else
      @user_language = current_user.selected_user_language
      render :new, status: :unprocessable_entity
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
