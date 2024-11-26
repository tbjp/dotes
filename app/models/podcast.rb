class Podcast < ApplicationRecord
  has_one_attached :audio

  belongs_to :user_language
  belongs_to :host

  validates :title, presence: true
  validates :summary, presence: true
  validates :ai_summary, presence: true
  validates :native_language, presence: true
  validates :level, presence: true
  validates :learning_style, presence: true
  validates :user_prompt, presence: true
end
