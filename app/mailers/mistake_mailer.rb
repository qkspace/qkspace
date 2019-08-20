class MistakeMailer < ApplicationMailer
  def mistake(text_msg, url, author, title)
    @body = text_msg
    @page = url
    @author = author

    @title = title

    mail(
      to: @author,
      subject: I18n.t('mistake_mailer.mistake.subject', project: @title)
    )
  end
end
