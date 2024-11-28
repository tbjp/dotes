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
    # GenerateText.call(current_user, Podcast.first)
    # GenerateAudio.call

  end

  def create
    @podcast = Podcast.new(podcast_params)
    @podcast.user_language = current_user.selected_user_language # temporary
    @podcast.host = Host.first # temporary until we have select in form
    if @podcast.save
      transcript = GenerateText.call(current_user, @podcast)
      audio = GenerateAudio.call(transcript)
      @podcast.transcript = transcript
      redirect_to podcasts_path
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
    params.require(:podcast).permit(:title, :summary, :ai_summary, :native_language, :level, :learning_style, :user_prompt, :user_language_id)
  end
end
