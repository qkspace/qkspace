module SessionManagementConcern
  private

  def authorize_public_request!
    return unless @project.private?

    unless signed_in? && current_user.collaborates?(@project)
      @sign_in_link = redirect_to_public_private_project_url(@project, host: area_private_domain)
      render 'unauthorized'
      return
    end
  end

  def create_session_for_current_request!(type, attrs)
    s = type.new
    s.remote_addr = request.remote_addr
    s.user_agent = request.env['HTTP_USER_AGENT']
    s.attributes = attrs
    s.save!

    s
  end

  def create_user_token_session!(user)
    create_session_for_current_request!(Session::UserToken, user: user)
  end

  def create_project_secret_session!(project)
    create_session_for_current_request!(Session::ProjectSecretToken, project: project)
  end

  def authenticate_by_session_id
    session_id = cookies.encrypted["session_id"]
    return unless session_id

    Session.
      live.
      find_by(id: session_id)&.
      user
  end

  def current_user
    # 'nil' is valid result
    if @_current_user_set
      return @current_user
    end

    @_current_user_set = true

    @current_user = authenticate_by_session_id
  end

  def reset_redirect_location!
    session.delete("session_previous_location")
  end

  def require_user!
    return if current_user

    save_redirect_location!
    redirect_to sign_in_path
  end

  def save_redirect_location!
    session["session_previous_location"] = request.original_url
  end

  def sign_in(session)
    cookies.encrypted.permanent["session_id"] = {value: session.id}
    session
  end

  def signed_in?
    !! current_user
  end

  def sign_out
    cookies.encrypted.permanent["session_id"] = {value: nil}
    cookies.delete("session_id")
    true
  end

  def set_locale_for_user
    locale = session[:locale]
    current_user&.update(locale: locale)
  end
end
