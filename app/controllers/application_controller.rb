class ApplicationController < ActionController::Base
  before_action :set_locale

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
    host =
      if project.domain
        project.domain
      else
        project.slug + '.' + request.host
      end
    URI::HTTP.build(host: host, port: request.port)
  end

  def public_project_url(project)
    public_project_page_uri(project).to_s
  end

  def public_project_page_url(project, page)
    uri = public_project_page_uri(project)
    uri.path = "/" << page.slug
    uri.to_s
  end

  def set_locale
    new_locale =
      if I18n.available_locales.map(&:to_s).include?(params[:locale])
        params[:locale]
      elsif session[:locale].present?
        session[:locale]
      else
        http_accept_language.compatible_language_from(I18n.available_locales) || I18n.default_locale
      end

    session[:locale] = new_locale
    I18n.locale = new_locale
  end
end
