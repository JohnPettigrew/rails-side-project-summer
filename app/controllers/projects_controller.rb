class ProjectsController < ApplicationController
  load_and_authorize_resource
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
      tweet_project_change("I just started a new project for #SideProjectSummer! It's called '" + project_abbrev_for_twitter + "' - see what I'm doing at " + project_url(@project), "Project created and tweet posted!")
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
    @projects = Project.all.page(params[:page]).per_page(10)
  end

  def edit
   @project=Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    project_params[:description]=project_params[:description][0..1499]
    if current_user.admin && @project.user_id!=current_user.id
      if @project.update_columns(name: project_params[:name], description: project_params[:description], source: project_params[:source], finished: project_params[:finished])
        flash[:notice] = "Project updated"
        redirect_to project_path(@project)
      else
        flash[:alert] = "Attempted update failed"
        render 'edit'
      end
    else
      if @project.update_attributes(project_params)
        flash[:notice] = "Project updated"
        if @project.finished && @project.saved_change_to_finished?
          tweet_project_change("I just finished a project for #SideProjectSummer! It's called '" + project_abbrev_for_twitter + "' - see what I did at " + project_url(@project), "Project created and tweet posted!")
        else
          tweet_project_change("I just updated a project for #SideProjectSummer! It's called '" + project_abbrev_for_twitter + "' - see what I'm doing at " + project_url(@project), "Project created and tweet posted!")
        end
        redirect_to project_path(@project)
      else
        flash[:alert] = "Attempted update failed"
        render 'edit'
      end
    end
  end

  private

    def project_params
      params.require(:project).permit(:description, :source, :name, :finished)
    end

    def correct_user
      @project = current_user.projects.find_by(id: params[:id])
      redirect_to root_url if @project.nil? && !current_user.admin
    end

    def project_abbrev_for_twitter
      @project.name[0..100]
    end

    def tweet_project_change(tweet, flash_notice)
      if current_user.twitter_key
        if Rails.env.production?
          current_user.twitter_details.update(tweet)
          flash[:notice]=flash_notice
        else
          flash[:notice]="In Production, I would have tweeted: " + tweet
        end
      end
    end
end

