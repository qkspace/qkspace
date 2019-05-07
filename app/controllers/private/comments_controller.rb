class Private::CommentsController < PrivateController
  before_action :require_user!
  before_action :set_project

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to private_project_page_path(@project, @commentable) }
        format.js
      end
    else
      redirect_to private_project_page_path(@project, @commentable), alert: t('comments.warning')
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    @comment.destroy if @comment.user == current_user
    redirect_to private_project_page_path(@project, @commentable)
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end
end
