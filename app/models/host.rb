class Host < ApplicationRecord
  has_many :podcasts

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :voice, presence: true
  validates :stories, presence: true
  validates :nationality, presence: true
  validates :age, presence: true
  validates :location, presence: true
  validates :family, presence: true
  validates :likes, presence: true
  validates :dislikes, presence: true
  validates :hobbies, presence: true

  def profile_for_prompt
    <<~PROFILE
      Host Profile:
      Name: #{first_name} #{last_name}
      Voice: #{voice}
      Nationality: #{nationality}
      Age: #{age}
      Location: #{location}
      Work: #{work}
      Family: #{family}
      Likes: #{likes}
      Dislikes: #{dislikes}
      Hobbies: #{hobbies}
      Stories: #{stories.join(', ')}
    PROFILE
  end
end
