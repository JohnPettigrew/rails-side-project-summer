class UsersController < ApplicationController
  load_and_authorize_resource
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:index]

  def show
    @user = User.find(params[:id])
    @projects = @user.projects.page(params[:page]).per_page(10)
  end

  def index
    @users = User.all.page(params[:page]).per_page(20)
  end

  def admin_destroy
    @user = User.find(params[:id])
    @user.destroy
    if @user.destroy
      redirect_to users_path, notice: "User " + @user.name + " deleted."
    else
      redirect_to users_path, alert: "User deletion failed. Please try again."
    end
  end

  def admin_edit
    @user = User.find(params[:id])
  end

  def admin_patch
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path, notice: "User updated. New details: " + @user.name + " at " + @user.email
    else
      redirect_to users_path, alert: "Update failed. Please try again."
    end
  end

  def twitter_disconnect
    current_user.update_columns(twitter_key: nil)
    current_user.update_columns(twitter_secret: nil)
    current_user.update_columns(twitter_user_url: nil)
    current_user.update_columns(uid: nil)
    current_user.update_columns(provider: nil)
    flash[:notice]="Successfully removed Twitter connection from your account."
    redirect_to user_path(current_user)
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
