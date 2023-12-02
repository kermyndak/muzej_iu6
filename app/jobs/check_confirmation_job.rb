class CheckConfirmationJob < ApplicationJob
  queue_as :default

  def perform(admin)
    unverified_users = User.where(confirmed_at: nil, created_at: ..3.days.ago)
    if unverified_users.length > 0
      AdminMailer.with(users: unverified_users, admin: admin).send_deleted_user.deliver_now
      unverified_users.delete_all
    end
  end
end