module Private
  class DiscussionsController < PrivateController
    before_action :set_project
    before_action :set_page
    before_action :ensure_discussions_enabled

    def create
      @discussion = @page.discussions.new(discussion_params)
      @discussion.user = current_user

      Discussion.transaction do
        @discussion.save!
        @discussion.set_path!
      end

      redirect_to private_project_page_path(@project, @page, anchor: "#{helpers.dom_id(@discussion)}_itself")
    end

    def destroy
      @discussion = @page.discussions.find(params[:id])

      if @project.owner == current_user || discussion.user == current_user
        @discussion.soft_delete!
      end

      redirect_to private_project_page_path(@project, @page)
    end

    private

    def ensure_discussions_enabled
      redirect_back(fallback_location: private_project_path(@project)) unless @project.discussions_enabled?
    end

    def discussion_params
      params.require(:discussion).permit(:source, :parent_id)
    end
  end
end
