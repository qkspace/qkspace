class PrivateController < ApplicationController
  before_action :authenticate_user!

  private

  def public_controller?
    false
  end

  def ensure_user_is_confirmed!
    unless current_user&.confirmed?
      redirect_to new_user_confirmation_path, alert: t('devise.failure.unconfirmed')
    end
  end
end
