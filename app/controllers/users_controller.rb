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
end
