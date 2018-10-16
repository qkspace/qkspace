class Private::ProjectsController < PrivateController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = current_user.projects
  end

  def show
    page = @project.pages.first

    redirect_to private_project_page_path(@project, page)
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = current_user.projects.new(project_params)

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
        domain: request.env['qkspace.area'][:private_domain]
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
end
