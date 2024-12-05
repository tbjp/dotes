class Flashcard < ApplicationRecord
  belongs_to :podcast
  after_update_commit :broadcast_progress

  def broadcast_progress
    broadcast_replace_to "podcast_#{podcast.id}_progress",
                        partial: "flashcards/progress",
                        locals: { podcast: podcast },
                        target: "progress"
  end
end
