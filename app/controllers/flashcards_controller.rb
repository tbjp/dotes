class FlashcardsController < ApplicationController
  def update
    @flashcard = Flashcard.find(params[:id])
    @flashcard.update(flashcard_params)
    @new_flashcard = @flashcard.podcast.incomplete_flashcard
    respond_to do |format|
      format.json { render(partial: "podcasts/flashcard_form", formats: :html, locals: {flashcard: @new_flashcard, podcast: @flashcard.podcast}) }
    end
  end

  private

  def flashcard_params
    params.require(:flashcard).permit(:correct)
  end
end
