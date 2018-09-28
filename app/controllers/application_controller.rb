class ApplicationController < ActionController::Base
  include HttpAcceptLanguage::AutoLocale

  protect_from_forgery with: :reset_session

  helper_method :private_controller?, :public_controller?,
                :public_project_url, :public_project_page_url

  private

  def public_controller?
    false
  end

  def private_controller?
    !public_controller?
  end

  def public_project_page_uri(project)
    URI::HTTP.build(host: (project.slug + '.' + request.host), port: request.port)
  end

  def public_project_url(project)
    public_project_page_uri(project).to_s
  end

  def public_project_page_url(project, page)
    uri = public_project_page_uri(project)
    uri.path = "/" << page.slug
    uri.to_s
  end
end
