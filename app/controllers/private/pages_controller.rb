class Private::PagesController < PrivateController
  before_action :set_project
  before_action :set_page, only: %i[show edit update destroy next previous]

  def show
  end

  def next
    @page = @project.pages.find_by(position: @page.position + 1) || @page
    redirect_to private_project_page_path(@project, @page)
  end

  def previous
    @page = @project.pages.find_by(position: @page.position - 1) || @page
    redirect_to private_project_page_path(@project, @page)
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = @project.pages.new(page_params)

    if @page.save
      generate_og_image

      redirect_to private_project_page_path(@project, @page), notice: t('.notice')
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      generate_og_image

      redirect_to private_project_page_path(@project, @page), notice: t('.notice')
    else
      render :edit
    end
  end

  def move
    @page = @project.pages.find(params[:id])
    @page.move_to! params[:position]
  end

  def destroy
    @page.destroy
    redirect_to private_project_path(@project), notice: t('.notice')
  end

  private

  def page_params
    params.require(:page).permit(:title, :source)
  end

  def set_page
    @page = @project.pages.find(params[:id])
  end

  def set_project
    @project = current_user.projects.find(params[:project_id])
  end

  def generate_og_image
    OgImageWorker.perform_async(@project.id, @page.id, @page.title)
  end
end
