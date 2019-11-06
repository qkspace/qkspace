class MistakeController < PublicController
  before_action :locale_from_headers, :set_locale, only: [:create]

  def create
    text_msg = mistake_params[:content]
    url = mistake_params[:url]

    title = @project.title

    owner = @project.owner.email
    collaborators = @project.collaborators.pluck(:email)

    locales = ([@project.owner] + @project.collaborators).map(&:locale) 
    emails = ([@project.owner] + @project.collaborators).map(&:email)
    
    emails.each_with_index do |author, index|
      MistakeMailer.
        with(
          text_msg: text_msg,
          url: url,
          author: author,
          title: title,
          locale: locales[index]
        ).
        mistake.
        deliver
    end

    redirect_to root_path, notice: I18n.t('mistake_controller.create.success')
  end

  private

  def mistake_params
    params.require(:mistake).permit(:content, :url)
  end

  def locale_from_headers
    request.env["HTTP_ACCEPT_LANGUAGE"].to_s.scan(/\A[a-z]{2}\z/i).first
  end

  def set_locale
    locale =
      [params[:locale], current_user&.locale, locale_from_headers, I18n.default_locale]
      .compact
      .map(&:to_sym)
      .select { |l| I18n.available_locales.include?(l) }
      .first

    current_user&.update(locale: locale) unless current_user&.locale == locale

    I18n.locale = locale
  end
end
