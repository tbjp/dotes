class UserLanguage < ApplicationRecord
  belongs_to :user
  has_many :podcasts, dependent: :destroy

  validates :language, presence: true
  validates :level, presence: true
end
