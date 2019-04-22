class ProjectsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!, :except => [:show, :index]
  before_action :correct_user, only: [:destroy, :update]

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:notice] = "Project created!"
      redirect_to user_path(current_user)
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project deleted"
    redirect_to user_path(current_user)
  end

  def index
    @projects = Project.all.paginate(page: params[:page], per_page: 20)
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated"
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  private

    def project_params
      params.require(:project).permit(:description, :source, :name)
    end

    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_url if @project.nil?
    end
end
