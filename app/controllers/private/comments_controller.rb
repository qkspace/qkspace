module Private
  class CommentsController < PrivateController
    before_action :set_project
    before_action :set_page

    def create
      return unless valid_user?

      @comment = @page.comments.new(comment_params)
      @comment.user = current_user

      if @comment.save
        @comment.set_path(@project.id)
        respond_to do |format|
          format.html { redirect_to private_project_page_path(@project, @page) }
          format.js
        end
      else
        redirect_to private_project_page_path(@project, @page), alert: t('comments.warning')
      end
    end

    def destroy
      @comment = @page.comments.find(params[:id])
      @comment.soft_delete! if @comment.user == current_user
      redirect_to private_project_page_path(@project, @page)
    end

    private

    def comment_params
      params.require(:comment).permit(:body, :parent_id)
    end

    def valid_user?
      current_user.projects.ids.include?(@page.project_id)
    end
  end
end
