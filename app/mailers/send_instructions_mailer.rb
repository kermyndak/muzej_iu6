class SendInstructionsMailer < ApplicationMailer
  def send_mail_for_sign_in
    @user = params[:user]
    @password = params[:password]
    mail to: @user.email, subject: 'Instructions for sign in'
  end
end