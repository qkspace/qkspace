class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

  protect_from_forgery with: :exception

  helper_method :project_url

  def project_url(project)
    root_url(subdomain: project.slug)
  end

  def set_project
    @project = Project.find_by(slug: request.subdomain)
  end

  def set_project_from_current_user
    @project = current_user.projects.find_by(slug: request.subdomain)
    @project ||= current_user.projects.find(params[:id])
  end
end
