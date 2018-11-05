class PublicController < ApplicationController
  before_action :set_project

  helper_method :project_url

  private

  def public_controller?
    true
  end

  def set_project
    public_name = request.env["qkspace.area"][:public_name]

    if request.env["qkspace.area"][:public_type] == :subdomain
      @project = Project.find_by!(slug: public_name)
    else
      @project = Project.find_by!(domain: request.env["qkspace.area"][:public_name])
    end
  end
end
