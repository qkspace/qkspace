class Public::PagesController < PublicController
  before_action :authorize_public_request!
  before_action :set_page

  def show
  end

  def next
    @page = @project.pages.find_by(position: @page.position + 1) || @page
    redirect_to public_page_path(slug: @page.slug)
  end

  def previous
    @page = @project.pages.find_by(position: @page.position - 1) || @page
    redirect_to public_page_path(slug: @page.slug)
  end

  def mistake_report
    mistake_report_form =
      ::MistakeReportForm.new(params.fetch(:mistake, {}).permit(:text, :correction).merge(page: @page))

    if mistake_report_form.valid?
      MistakeReportMailer.
        with(url: public_project_page_url(@page), **mistake_report_form.attributes.symbolize_keys).
        notify.
        deliver_now
    end

    head :ok
  end

  private

  def set_page
    @page = @project.pages.find_by!(slug: params[:slug])
  end
end
