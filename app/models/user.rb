class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :create_user_languages


  has_many :user_languages, dependent: :destroy
  belongs_to :selected_user_language, class_name: "UserLanguage", optional: true
  has_many :podcasts, through: :user_languages
  validates :native_language, presence: true

  def create_user_languages
    self.selected_user_language = UserLanguage.create(language: 'Japanese', level: 'A1', user: self)
    self.save
    UserLanguage.create(language: 'Polish', level: 'A1', user: self)
    UserLanguage.create(language: 'English', level: 'A1', user: self)
  end

end
