class ProjectsController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate_user!

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
    redirect_back(fallback_location: root_url)
  end

  def index
    redirect_to root_url
  end

  private

    def project_params
      params.require(:project).permit(:description, :source, :name)
    end
end
