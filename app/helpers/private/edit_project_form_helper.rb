module Private::EditProjectFormHelper
  private

  def initialize_edit_project_form
    @project_with_domain_updater ||= ProjectWithDomainUpdater.new(area_private_domain: area_private_domain, project: @project)
    @collaboration ||= @project.collaborations.build
    @collaborations ||= @project.collaborations.includes(:user)
  end
end
