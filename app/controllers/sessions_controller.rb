class SessionsController < ApplicationController
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
