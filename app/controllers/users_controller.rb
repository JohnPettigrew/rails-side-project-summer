class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:index]

  def show
    @user = User.find(params[:id])
    @projects = @user.projects.page(params[:page]).per_page(20)
  end

  def index
    @users = User.all.page(params[:page]).per_page(20)
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
end
