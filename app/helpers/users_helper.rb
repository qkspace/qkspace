module UsersHelper
  def confirm_email_hint
    unless @user.confirmed?
      t('.confirm_email', url: new_user_confirmation_url).html_safe
    end
    # otherwise nil
  end
end
