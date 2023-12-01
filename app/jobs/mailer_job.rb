class MailerJob < ApplicationJob
    queue_as :default
  
  def perform(admin, user, password)
    begin
      SendInstructionsMailer.with(user: user, password: password).send_mail_for_sign_in.deliver_now   
    rescue Net::SMTPFatalError => e
      SendInstructionsMailer.with(admin: admin, email: user.email, error: e).fail_send_bad_email_address.deliver_now  
    end
  end
end