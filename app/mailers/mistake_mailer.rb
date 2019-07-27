class MistakeMailer < ApplicationMailer
  def mistake(txt_msg, url)
    @body = txt_msg
    @page = url
    @admin = 'install.vv@gmail.com'

    mail(
      to: @admin,
      subject: I18n.t('mistake_mailer.mistake.subject')
    )
  end
end
