class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_resending_confirmation_instructions_path_for(resource_name)
    '/'
  end
end
