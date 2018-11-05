class Private::ProjectsController < PrivateController
  before_action :set_project, only: %i[show]
  before_action :set_owned_project, only: %i[edit update update_domain destroy]

  include Private::EditProjectFormHelper

  def index
    @owned_projects = current_user.owned_projects
    @collaborated_projects = current_user.collaborated_projects
  end

  def show
    page = @project.pages.first

    redirect_to private_project_page_path(@project, page)
  end

  def new
    @project = Project.new
  end

  def edit
    initialize_edit_project_form
  end

  def create
    @project = current_user.owned_projects.new(project_params)

    if @project.save
      redirect_to private_projects_url, notice: t('.notice')
    else
      render :new
    end
  end

  def update
    if @project.update(project_params)
      redirect_to private_projects_url, notice: t('.notice')
    else
      initialize_edit_project_form
      render :edit
    end
  end

  def update_domain
    @project_with_domain_updater = ProjectWithDomainUpdater.new(area_private_domain: area_private_domain, project: @project)

    if @project_with_domain_updater.update(params[:project][:domain])
      redirect_to private_projects_url, notice: t('.notice')
    else
      initialize_edit_project_form
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to private_projects_url, notice: t('.notice')
  end

  def check_slug
    response =
      SlugChecker.call(
        slug: params[:slug],
        domain: area_private_domain
      )

    render json: { data: response }
  end

  private

  def project_params
    params.require(:project).permit(:title, :slug, :google_analytics_tracker_id)
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def set_owned_project
    @project = current_user.owned_projects.find(params[:id])
  end
end
