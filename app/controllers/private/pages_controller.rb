class Private::PagesController < PrivateController
  before_action :set_project
  before_action :set_page, only: %i[show edit update destroy next previous]

  def show
    respond_to do |format|
      format.html
      format.json { render json: @page }
    end
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

    respond_to do |format|
      if @page.save
        format.html { redirect_to private_project_page_path(@project, @page), notice: t('.notice') }
        format.json { render json: @page, status: :created }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to private_project_page_path(@project, @page), notice: t('.notice') }
        format.json { render json: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def move
    @page = @project.pages.find(params[:id])
    @page.move_to! params[:position]
  end

  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to private_project_path(@project), notice: t('.notice') }
      format.json { head :no_content }
    end

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
