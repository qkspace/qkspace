class SessionsController < Passwordless::SessionsController
  def new
    @session = Passwordless::Session.new
  end

  def create
    @session = build_passwordless_session(find_authenticatable)

    if @session.save
      link = main_app.token_sign_in_url(token: @session.token)

      UserMailer.with(
        session_id: @session.id,
        link: link
      ).
      magic_link.
      deliver_now

      redirect_to({action: :new}, notice: t('.email_sent'))
    else
      flash.now[:alert] = t('.error')
      render :new
    end
  end

  def show
    BCrypt::Password.create(params[:token])

    session = find_session
    if session.expired?
      flash[:alert] = t('.session_expired')
      redirect_to sign_in_url
      return
    end

    sign_in session

    destination = reset_passwordless_redirect_location!(User)
    if destination
      redirect_to destination
    else
      redirect_to "/"
    end
  end

  def destroy
    super
  end

  def sign_out_everywhere
    now = Time.current

    Passwordless::Session.
      where(authenticatable: current_user).
      where('expires_at > ?', now).
      update_all(expires_at: now)

    destroy
  end

  private

  def authenticatable
    'user'
  end
end
