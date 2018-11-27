class UserMailer < ApplicationMailer
  def invited_to_project
    @collaboration = ProjectCollaboration.find(params[:collaboration_id])
    @private_link = params[:private_link]

    mail(
      to: @collaboration.user.email,
      subject: I18n.t('user_mailer.invited_to_project.subject', project: @collaboration.project.title)
    )
  end

  def magic_link
    @session = Passwordless::Session.find(params[:session_id])

    @link = params[:link]

    mail(
      to: @session.authenticatable.email,
      subject: I18n.t('user_mailer.magic_link.subject')
    )
  end
end
