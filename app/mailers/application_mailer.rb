class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@qkspace.com'
  layout 'template_mail'
end
