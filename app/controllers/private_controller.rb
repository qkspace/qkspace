class PrivateController < ApplicationController
  before_action :require_user!

  private

  def public_controller?
    false
  end

  def set_page
    @page = @project.pages.find(params[:id])
  end

  def set_project
    @project = current_user.projects.find(params[:id])
  end

  def set_owned_project
    @project = current_user.owned_projects.find(params[:id])
  end
end
