class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
