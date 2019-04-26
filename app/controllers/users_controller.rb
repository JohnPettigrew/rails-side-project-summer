class UsersController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:index]

  def show
    @user = User.find(params[:id])
    @projects = @user.projects.paginate(page: params[:page])
  end

  def index
    @users = User.all.paginate(page: params[:page], per_page: 10)
  end
end
