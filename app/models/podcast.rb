class Podcast < ApplicationRecord
  has_one_attached :audio

  has_many :flashcards, dependent: :destroy
  belongs_to :user_language
  belongs_to :host

  validates :level, presence: true
  validates :learning_style, presence: true
  validates :user_prompt, presence: true

  # attribute :status, :string, default: "new"

  LANGUAGES = ["English", "Polish", "Japanese"]
  LEARNING = ["Serious", "Casual", "Balanced", "Calm", "Funny", "Charming"]
  LEVELS = {
    "A1" => "Beginner",
    "A2" => "Elementary",
    "B1" => "Intermediate",
    "B2" => "Advanced",
    "C1" => "Proficient",
    "C2" => "Expert"
  }
  STATUS = ["new", "failed", "completed"]

  # after_update_commit :broadcast_podcast
  # after_update_commit :broadcast_audio

  def incomplete_flashcard
    self.flashcards.where.not(correct: true).sample
  end

  def broadcast_podcast
    broadcast_replace_to "podcast_#{self.id}",
                        partial: "podcasts/podcast",
                        locals: { podcast: self, flashcard: incomplete_flashcard },
                        target: "podcast"
  end

  def broadcast_audio
    broadcast_replace_to "podcast_#{self.id}",
                        partial: "podcasts/audio",
                        locals: { podcast: self, flashcard: incomplete_flashcard },
                        target: "audio"
  end

end
