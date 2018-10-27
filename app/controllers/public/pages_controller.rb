class Public::PagesController < PublicController
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

  def set_page
    @page = @project.pages.find_by!(slug: params[:slug])
  end
end
