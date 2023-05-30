class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:edit_username, :update_username, :edit_password, :update_password]


  def edit
    @user = current_user
  end

  # def update
  #   @user = current_user

  #   if @user.update(user_params)
  #     redirect_to profile_path, notice: 'Profile updated successfully.'
  #   else
  #     render :edit
  #   end
  # end

  def change_username
    @user = current_user
  end

  def update_username
    @user = current_user
  
    if @user.update_column(:username, user_params[:username])
      redirect_to edit_profile_path, notice: 'Username updated successfully.'
    else
      render :change_username
    end
  end

  def change_password
    @user = current_user
  end

  def update_password
    @user = current_user

    if @user.update_with_password(password_params)

      bypass_sign_in(@user)
      redirect_to edit_profile_path, notice: 'Password updated successfully.'
    else
      render :change_password
    end
  end

  private


    def user_params
    params.require(:user).permit(:username)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation, :current_password)
  end
end
