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

  def incomplete_flashcard
    self.flashcards.where.not(correct: true).sample
  end

  def broadcast_podcast
    broadcast_replace_to "podcast_#{self.id}",
                        partial: "podcasts/podcast",
                        locals: { podcast: self },
                        target: "podcast"
  end

  def broadcast_audio
    broadcast_replace_to "podcast_#{self.id}",
                        partial: "podcasts/audio",
                        locals: { podcast: self },
                        target: "audio"
  end

  def flashcard_completion_percentage
    return 0 if flashcards.empty?

    (flashcards.where(correct: true).count.fdiv(flashcards.count) * 100).round

  end

  def duration_formatted
    return "0m 00s" if duration.nil?
    minutes = duration / 60
    seconds = duration % 60
    "#{minutes}m #{seconds.to_s.rjust(2, '0')}s"
  end
end
