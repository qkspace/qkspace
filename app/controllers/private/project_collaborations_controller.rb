class Private::ProjectCollaborationsController < PrivateController
  before_action :set_owned_project, only: %i[create index]
  before_action :set_project, only: %i[destroy]

  before_action :set_collaboration, only: %i[destroy]

  def create
    @collaboration = @project.collaborations.new(collaboration_params)

    if @collaboration.save
      collaborator_session = create_session_for_current_request!(@collaboration.user)

      UserMailer.
        with(
          collaboration_id: @collaboration.id,
          private_link: token_sign_in_url(token: collaborator_session.token)
        ).
        invited_to_project.
        deliver_now

      redirect_to private_project_collaborators_path(@project), notice: t('.notice')
    else
      set_collaborations
      render 'index'
    end
  end

  def destroy
    @collaboration.destroy

    if current_user.owns?(@project)
      redirect_to private_project_collaborators_path(@project), notice: t('.notice')
    else
      redirect_to private_projects_path, notice: t('.notice')
    end
  end

  def index
    set_collaborations
    @collaboration = @project.collaborations.build
  end

  private

  def collaboration_params
    params.require(:project_collaboration).permit(:collaborator_email)
  end

  def set_collaboration
    @collaboration =
      if current_user.owns?(@project)
        @project.collaborations.find(params[:id])
      else
        @project.collaborations.find_by!(id: params[:id], user: current_user)
      end
  end

  def set_collaborations
    @collaborations = @project.collaborations.includes(:user)
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_owned_project
    @project = current_user.owned_projects.find(params[:project_id])
  end
end
