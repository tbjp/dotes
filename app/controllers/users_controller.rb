class UsersController < ApplicationController

  def edit

  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to root_path
    else
      render "/"
    end
  end

  private

  def user_params
    params.require(:user).permit(:selected_user_language_id)
  end
end
