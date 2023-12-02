require 'sidekiq-scheduler'

class DeleteUsersWithoutConfirmationScheduler
  include Sidekiq::Worker

  def perform
    unverified_users = User.where(confirmed_at: nil, created_at: ..3.days.ago)
    if unverified_users.length > 0
      admins = User.where(role: 'admin').where.not(email: 'admin@admin.ru')
      admins.each do |admin|
        AdminMailer.with(users: unverified_users, admin: admin).send_deleted_user.deliver_now
      end
      unverified_users.delete_all
    end
  end
end