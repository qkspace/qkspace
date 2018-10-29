module UsersHelper
  def cancel_link
    link_to t('.cancel_link_text'), destroy_user_confirmation_url, method: :delete
  end

  def confirm_email_hint
    unless @user.confirmed?
      return t('.confirm_email', url: new_user_confirmation_url).html_safe
    end

    if @user.pending_reconfirmation?
      t(
        '.currently_waiting_confirmation_for_email',
        email: @user.unconfirmed_email,
        url: new_user_confirmation_url,
        cancel_link: cancel_link
      ).html_safe
    end
    # otherwise nil
  end

  def current_user_email_to_confirm
    if current_user.pending_reconfirmation?
      current_user.unconfirmed_email
    else
      current_user.email
    end
  end
end
