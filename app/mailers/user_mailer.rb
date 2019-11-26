class UserMailer < ApplicationMailer
  def password_reset user
    @user = user
    mail to: user.email, subject: I18n.t(".reset_password")
  end
end
