class UserLanguage < ApplicationRecord
  belongs_to :user
  has_many :podcasts

  validates :language, presence: true
  validates :level, presence: true
end
