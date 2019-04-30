class Private::Pages::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Page.find(params[:page_id])
  end
end
