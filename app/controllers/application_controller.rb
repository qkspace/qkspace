class ApplicationController < ActionController::Base
  before_action :set_locale

  protect_from_forgery with: :reset_session

  helper_method :current_user, :signed_in?,
                :private_controller?, :public_controller?,
                :area_private_domain

  include PublicUrlHelper
  include Passwordless::ControllerHelpers

  private

  def area_private_domain
    request.env['qkspace.area'][:private_domain]
  end

  def area_public_name
    request.env['qkspace.area'][:public_name]
  end

  def area_public_type
    request.env['qkspace.area'][:public_type]
  end

  def area_of_subdomain?
    area_public_type == :subdomain
  end

  def current_user
    @current_user ||= authenticate_by_cookie(User)
  end

  def public_controller?
    false
  end

  def private_controller?
    !public_controller?
  end

  def require_user!
    return if current_user

    save_passwordless_redirect_location!(User)
    redirect_to sign_in_path
  end

  def signed_in?
    !! current_user
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
