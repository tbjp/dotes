class Podcast < ApplicationRecord
  has_one_attached :audio

  belongs_to :user_language
  belongs_to :host

  validates :native_language, presence: true
  validates :level, presence: true
  validates :learning_style, presence: true
  validates :user_prompt, presence: true

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
end
