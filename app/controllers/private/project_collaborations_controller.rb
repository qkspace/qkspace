class Private::ProjectCollaborationsController < PrivateController
  before_action :set_project, only: %i[index destroy]
  before_action :set_owned_project, only: %i[create]
  before_action :set_collaborations, only: %i[index create]
  before_action :set_collaboration, only: %i[destroy]

  def create
    @collaboration = @project.collaborations.new(collaboration_params)

    if @collaboration.save
      redirect_to edit_private_project_path(@project), notice: t('.notice')
    else
      render "private/projects/edit"
    end
  end

  def destroy
    @collaboration.destroy

    if current_user.owns?(@project)
      redirect_to edit_private_project_path(@project), notice: t('.notice')
    else
      redirect_to private_projects_path, notice: t('.notice')
    end
  end

  private

  def collaboration_params
    params.require(:project_collaboration).permit(:collaborator_email)
  end

  def set_collaborations
    @collaborations = @project.collaborations.preload(:user)
  end

  def set_collaboration
    @collaboration =
      if current_user.owns?(@project)
        @project.collaborations.find(params[:id])
      else
        @project.collaborations.find_by!(id: params[:id], user: current_user)
      end
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def set_owned_project
    @project = current_user.owned_projects.find(params[:project_id])
  end
end
