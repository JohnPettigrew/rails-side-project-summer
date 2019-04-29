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
      tweet_new_project(project_params)
      redirect_to user_path(current_user)
    else
      flash[:alert] = "There was an error. Your project was not created."
      render 'static_pages/home'
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = "Project deleted"
    redirect_to user_path(current_user)
  end

  def index
    @projects = Project.all.page(params[:page]).per_page(20)
  end

  def edit
   @project=Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(project_params)
      flash[:notice] = "Project updated"
      if @project.finished && @project.saved_change_to_finished?
       tweet_finished_project
      else
        tweet_updated_project
      end
      redirect_to user_path(current_user)
    else
      render 'edit'
    end
  end

  private

    def project_params
      params.require(:project).permit(:description, :source, :name, :finished)
    end

    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_url if @project.nil?
    end

    def tweet_new_project(params)
      if current_user.twitter_key
        project_name=@project.name[0..100]
        tweet="I just started a new project for #SideProjectSummer! It's called '" + project_name + "' - see what I'm doing at " + project_url
        if Rails.env.production?
          current_user.twitter_details.update(tweet)
          flash[:notice]="Project created and tweet posted!"
        else
          raise tweet
        end
      end
    end

    def tweet_updated_project
      if current_user.twitter_key
        project_name=@project.name[0..100]
        tweet="I just updated a project for #SideProjectSummer! It's called '" + project_name + "' - see what I'm doing at " + project_url
        if Rails.env.production?
          current_user.twitter_details.update(tweet)
          flash[:notice]="Project updated and tweet posted!"
        else
          raise tweet
        end
      end
    end

    def tweet_finished_project
      if current_user.twitter_key
        project_name=@project.name[0..100]
        tweet="I just finished a project for #SideProjectSummer! It's called '" + project_name + "' - see what I did at " + project_url
        if Rails.env.production?
          current_user.twitter_details.update(tweet)
          flash[:notice]="Project marked as finished and tweet posted!"
        else
          raise tweet
        end
      end
    end
end

