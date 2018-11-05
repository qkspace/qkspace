module Private::EditProjectFormHelper
  private

  def initialize_edit_project_form
    @project_with_domain_updater ||= ProjectWithDomainUpdater.new(request: request, project: @project)
    @collaboration ||= @project.collaborations.build
    @collaborations ||= @project.collaborations.includes(:user)
  end
end
