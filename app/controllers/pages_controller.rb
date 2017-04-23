class PagesController < ApplicationController
  before_action :authenticate_user!, only: [
    :new, :edit, :create, :update, :destroy
  ]

  before_action :set_project, only: [:show]

  before_action :set_project_from_current_user, only: [
    :new, :edit, :move, :create, :update, :destroy
  ]

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

    respond_to do |format|
      if @page.save
        format.html { redirect_to page_path(@page), notice: 'Страница создана' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to page_path(@page), notice: 'Страница обновлена' }
      else
        format.html { render :edit }
      end
    end
  end

  def move
    @page = @project.pages.find_by(slug: params[:slug])
    @page.move_to! params[:position]
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to project_url(@project), notice: 'Страница удалена' }
    end
  end

  private

  def set_page
    @page = @project.pages.find_by(slug: params[:slug])
  end

  def page_params
    params.require(:page).permit(:title)
  end
end
