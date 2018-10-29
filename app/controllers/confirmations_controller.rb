class ConfirmationsController < Devise::ConfirmationsController
  before_action :authenticate_user!

  def destroy
    current_user.confirmation_token = nil
    current_user.unconfirmed_email = nil
    current_user.save!

    redirect_back fallback_location: edit_user_registration_path
  end

  private

  def after_resending_confirmation_instructions_path_for(resource_name)
    '/'
  end
end
