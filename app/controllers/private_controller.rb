class PrivateController < ApplicationController
  before_action :authenticate_user!

  private

  def public_controller?
    false
  end

  def confirm_user!
    unless current_user&.confirmed?
      redirect_to new_user_confirmation_path, notice: t('devise.failure.unconfirmed')
    end
  end
end
