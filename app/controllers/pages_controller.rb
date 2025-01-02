class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @demo_user = User.find(1)
  end

  def settings
    # interests
    # learning style
    # native language
    # suggested topic
    # selected user language id
  end
end
