class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_languages, dependent: :destroy
  belongs_to :selected_user_language, class_name: "UserLanguage", optional: true
  has_many :podcasts, through: :user_languages
end
