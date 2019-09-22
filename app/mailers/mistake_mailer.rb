class MistakeMailer < ApplicationMailer
  def mistake
    @body = params[:text_msg]
    @page_link = params[:url]

    author = params[:author]
    title = params[:title]
    locale = params[:locale]

    I18n.with_locale(locale) do
      mail(
        to: author,
        subject: I18n.t('mistake_mailer.mistake.subject', project: title)
      )
    end  
  end
end
