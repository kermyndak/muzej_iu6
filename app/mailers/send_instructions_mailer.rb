class SendInstructionsMailer < ApplicationMailer
  def send_mail_for_sign_in
    @user = params[:user]
    @password = params[:password]
    mail to: @user.email, subject: 'Инструкции к входу'
  end

  def fail_send_bad_email_address 
    @admin = params[:admin]
    @email = params[:email]
    @error = params[:error]
    mail to: @admin.email, subject: 'Отправка не удалась'
  end
end