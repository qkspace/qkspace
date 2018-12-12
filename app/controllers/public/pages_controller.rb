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

    # if signed_in? && current_user.projects.where(id: @project.id).exists?
    #   return
    # end

    # save_passwordless_redirect_location!(User)
    # redirect_to users.sign_in_url
  end

  def set_page
    @page = @project.pages.find_by!(slug: params[:slug])
  end
end
