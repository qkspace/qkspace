class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  before_action :set_project, only: [:show]

  before_action :set_project_from_current_user, only: [:edit, :update, :destroy]

  def index
    @projects = current_user.projects
  end

  def show
    @page = @project.pages.first

    render 'pages/show'
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_url, notice: t('.notice') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to projects_url, notice: t('.notice') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: t('.notice') }
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :slug, :google_analytics_tracker_id)
  end
end
