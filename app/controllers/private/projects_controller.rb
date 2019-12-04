class Private::ProjectsController < PrivateController
  before_action :set_project, only: %i[show redirect_to_public]
  before_action :set_owned_project, only: %i[edit update update_domain destroy]

  def index
    @owned_projects = current_user.owned_projects

    collaborations = current_user.project_collaborations.includes(:user)
    @collaborated_projects = collaborations.map(&:project)
    @collaborations = collaborations.map { |x| [x.project.id, x] }.to_h
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
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to private_projects_url, notice: t('.notice')
  end

  def check_slug
    response =
      SlugCheckerService.call(
        slug: params[:slug],
        current_slug: params[:current_slug],
        domain: area_private_domain
      )

    render json: { data: response }
  end

  def redirect_to_public
    session = create_user_token_session!(current_user)

    redirect_to public_project_token_sign_in_url(@project, session.token)
  end

  private

  def project_params
    params.require(:project).permit(
      :title, :slug,
      :google_analytics_tracker_id,
      :yandex_metrika_tracker_id,
      :private, :secret_enabled
    )
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def set_owned_project
    @project = current_user.owned_projects.find(params[:id])
  end
end
