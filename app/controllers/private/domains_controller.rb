class Private::DomainsController < PrivateController
  before_action :set_owned_project
  before_action :set_project_domain_service

  include Private::EditProjectFormHelper

  def create
    if @project_domain_service.update(params[:project][:domain])
      redirect_to private_projects_url, notice: t('.notice')
    else
      initialize_edit_project_form
      render 'private/projects/edit'
    end
  end

  def destroy
    if @project_domain_service.destroy
      redirect_to private_projects_url, notice: t('.notice')
    else
      initialize_edit_project_form
      render 'private/projects/edit'
    end
  end

  private

  def set_owned_project
    @project = current_user.owned_projects.find(params[:project_id])
  end

  def set_project_domain_service
    @project_domain_service = ProjectDomainService.new(area_private_domain: area_private_domain, project: @project)
  end
end
