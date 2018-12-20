class Public::PagesController < PublicController
  before_action :authorize_project!
  before_action :set_page

  def show
  end

  def next
    @page = @project.pages.find_by(position: @page.position + 1) || @page
    redirect_to public_page_path(slug: @page.slug)
  end

  def previous
    @page = @project.pages.find_by(position: @page.position - 1) || @page
    redirect_to public_page_path(slug: @page.slug)
  end

  private

  def authorize_project!
    return unless @project.private?

    if signed_in? && current_user.projects.where(id: @project.id).exists?
      return
    else
      @sign_in_link = redirect_to_public_private_project_url(@project, host: area_private_domain)
      render 'unauthorized'
    end
  end

  def set_page
    @page = @project.pages.find_by!(slug: params[:slug])
  end
end
