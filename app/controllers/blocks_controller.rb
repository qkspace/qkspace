class BlocksController < ApplicationController
  before_action :set_page, :set_project
  before_action :set_block, only: [:show, :edit, :update, :destroy]

  def index
    @blocks = Block.all
  end

  def show
  end

  def new
    @block = Block.new
  end

  def edit
  end

  def create
    @block = @page.blocks.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { redirect_to project_page_path(@project, @page), notice: 'Block was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to project_page_path(@project, @page), notice: 'Block was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to project_page_path(@project, @page), notice: 'Block was successfully destroyed.' }
    end
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_page
    @page = Page.find(params[:page_id])
  end

  def set_block
    @block = Block.find(params[:id])
  end

  def block_params
    params.require(:block).permit(:source)
  end
end
