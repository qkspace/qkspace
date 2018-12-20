module SessionManagementConcern
  private

  def create_session_for_current_request!(user)
    s = Session.new
    s.remote_addr = request.remote_addr
    s.user_agent = request.env['HTTP_USER_AGENT']
    s.user = user
    s.save!

    s
  end

  def current_user
    # 'nil' is valid result
    if @_current_user_set
      return @current_user
    end

    @_current_user_set = true

    session_id = cookies.encrypted["session_id"]
    return unless session_id

    session = Session.live.find_by(session_id)

    @current_user = session&.user
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
    cookies.encrypted.permanent["session_id"] = { value: session.id }
    session
  end

  def signed_in?
    !! current_user
  end

  def sign_out
    cookies.encrypted.permanent["session_id"] = { value: nil }
    cookies.delete("session_id")
    true
  end
end
