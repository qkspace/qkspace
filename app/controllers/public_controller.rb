class PublicController < ApplicationController
  before_action :set_project

  helper_method :project_url

  private

  def public_controller?
    true
  end

  def set_project
    if area_of_subdomain?
      @project = Project.find_by!(slug: area_public_name)
    else
      @project = Project.find_by!(domain: area_public_name)
    end
  end
end
