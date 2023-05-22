class ProfilesController < ApplicationController
    before_action :authenticate_user!
  
    def show
      @user = current_user
    end
  
    def edit
      @user = current_user
    end
  
    def update
      @user = current_user
      if @user.update(user_params)
        flash[:success] = 'Profile updated successfully.'
        redirect_to profile_path
      else
        render :edit
      end
    end
  
    def change_password
      @user = current_user
    end
  
    def update_password
      @user = current_user
      if @user.update_with_password(password_params)
        # Sign in the user again to update the session
        bypass_sign_in(@user)
        flash[:success] = 'Password changed successfully.'
        redirect_to profile_path
      else
        render :change_password
      end
    end
  
    private
  
    def user_params
      params.require(:user).permit(:username)
    end
  
    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
    end
  end
  