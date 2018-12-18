module SessionManagementConcern
  private

  def authenticate_by_cookie(authenticatable_class)
    key = cookie_name(authenticatable_class)
    session_id = cookies.encrypted[key]
    return unless session_id

    session = Passwordless::Session.find_by(id: session_id)

    unless session.expired?
      session.authenticatable
    end

    # otherwise return nil
  end

  def current_user
    @current_user ||= authenticate_by_cookie(User)
  end

  def require_user!
    return if current_user

    save_passwordless_redirect_location!(User)
    redirect_to sign_in_path
  end

  def sign_in(session)
    key = cookie_name(session.authenticatable.class)
    cookies.encrypted.permanent[key] = { value: session.id }
    session
  end

  def signed_in?
    !! current_user
  end
end
