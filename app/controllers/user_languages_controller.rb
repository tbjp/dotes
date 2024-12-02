class UserLanguagesController < ApplicationController
  def update
    @user_language = User_language.find(params[:id]) # this is not in the params
    if @user_language.update(user_language_params)
      redirect_to root_path
    else
      render
    end
  end

  private
    def user_language_params
      params.require(:user_language).permit(:language)
    end
end
