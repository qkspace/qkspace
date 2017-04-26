class BlocksController < ApplicationController
  before_action :authenticate_user!

  before_action :set_project, :set_page
  before_action :set_block, only: [:edit, :update, :destroy]

  def new
    @block = Block.new
  end

  def edit
  end

  def create
    @block = @page.blocks.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { redirect_to page_path(@page), notice: t('.notice') }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to page_path(@page), notice: t('.notice') }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to page_path(@page), notice: t('.notice') }
    end
  end

  private

  def set_page
    @page = @project.pages.find_by(slug: params[:page_slug])
  end

  def set_block
    @block = @page.blocks.find(params[:id])
  end

  def block_params
    params.require(:block).permit(:source)
  end
end
