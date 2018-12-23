class Session::ProjectSecretTokensController < ApplicationController
  def show
    project =
      Project.
        where(secret_enabled: true, secret_token: params[:token]).
        first!

    session = create_project_secret_session!(project)
    sign_in session

    destination = reset_redirect_location! || "/"
    redirect_to destination
  end
end
