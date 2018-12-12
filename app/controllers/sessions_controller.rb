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
    super
  end

  def destroy
    super
  end

  private

  def authenticatable
    'user'
  end
end
