class AdminMailer < ApplicationMailer
  def send_deleted_user
    @users = params[:users]
    @admin = params[:admin]
    mail to: @admin.email, subject: "Чистка пользователей"
  end
end