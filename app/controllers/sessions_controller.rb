class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:session][:email]).first

    unless user
      flash.now.alert = t('.error')
      render :new
      return
    end

    session = create_session_for_current_request!(user)

    link = token_sign_in_url(token: session.token)

    UserMailer.
      with(
        session_id: session.id,
        link: link
      ).
      magic_link.
      deliver_now

    redirect_to({action: :new}, notice: t('.email_sent'))
  end

  def show
    session = Session.find_for_token_login!(params[:token])
    sign_in session

    destination = reset_redirect_location! || "/"
    redirect_to destination
  end

  def destroy
    sign_out
    redirect_to "/"
  end

  def sign_out_everywhere
    now = Time.current

    Session.
      where(user: current_user).
      update_all(active: false)

    destroy
  end
end
