class Notifier < ActionMailer::Base
  default from: EMAIL_FROM

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.company_welcome.subject
  #
  def company_welcome(user, token)
    @user = user
    @token = token
    mail to: user.email, subject: 'Bienvenido a Incyde'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.business_incubator_welcome.subject
  #
  def business_incubator_welcome(user, token)
    @user = user
    @token = token
    mail to: user.email, subject: 'Bienvenido a Incyde'
  end

  def notification_platform(notification, recipients)
    @body = notification.body
    mail to: EMAIL_FROM, bcc: recipients, subject: notification.subject
  end

end
