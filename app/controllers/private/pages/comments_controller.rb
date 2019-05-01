class Private::Pages::CommentsController < Private::CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = @project.pages.find(params[:page_id])
  end
end
