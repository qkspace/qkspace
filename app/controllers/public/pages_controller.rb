class Public::PagesController < PublicController
  before_action :set_page

  def show
  end

  private

  def set_page
    @page = @project.pages.find_by!(slug: params[:slug])
  end
end
