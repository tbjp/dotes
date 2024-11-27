class PodcastsController < ApplicationController
  def index
    @podcasts = Podcast.all
  end

  def show
    @podcast = Podcast.find(params[:id])
  end

  def new
    @podcast = Podcast.new

    # Toby's testing
    # GenerateText.call(current_user, Podcast.first)
  end

  def create
    @podcast = Podcast.new(podcast_params)
    if @podcast.save
      redirect_to podcasts_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @podcast = Podcast.find(params[:id])
    @podcast.delete
  end

  private

  def podcast_params
    params.require(:podcast).permit(:title, :summary, :ai_summary, :native_language, :level, :learning_style, :user_prompt)
  end
end
