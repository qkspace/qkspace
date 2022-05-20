class MistakeReportMailer < ApplicationMailer
  def notify
    page = params[:page]
    project = page.project

    mail(
      to: self.class.default[:from],
      bcc: project.editors.pluck(:email),
      subject: default_i18n_subject(page: page.title, project: project.title)
    )
  end
end
