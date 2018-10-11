class Public::ProjectsController < PublicController
  def show
    redirect_to public_page_url(@project.pages.first.slug)
  end
end
