class Session::UserTokensController < ApplicationController
  def new
  end

  def create
    user = User.where(email: params[:session][:email]).first

    unless user
      flash.now.alert = t('.error')
      render :new
      return
    end

    session = create_user_token_session!(user)

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
    session = Session::UserToken.find_for_login!(params[:token])
    sign_in session

    destination = reset_redirect_location! || "/"
    redirect_to destination
  end
end
