class UsersController < ApplicationController
  before_action :require_user!, only: %i[edit update destroy]
  before_action :set_user, only: %i[edit update destroy]

  def create
    @user = User.new(user_params)

    captcha_is_valid = verify_recaptcha

    if @user.save && captcha_is_valid
      session = create_user_token_session!(@user)

      sign_in session
      redirect_to '/'
    else
      flash.now[:alert] = t('.wrong_captcha') unless captcha_is_valid
      render :new
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to action: :edit, notice: t('.notice')
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!

    redirect_to '/', notice: t('.notice')
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
