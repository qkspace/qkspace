class Private::PagesController < PrivateController
  before_action :set_project
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = @project.pages.new(page_params)

    if @page.save
      redirect_to private_project_page_path(@project, @page), notice: t('.notice')
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
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
    redirect_to project_url(@project), notice: t('.notice')
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
end
