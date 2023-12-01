class CheckConfirmationJob < ApplicationJob
  queue_as :default

  def checker
    unverified_users = User.where(confirmed_at: nil, created_at: ..3.days.ago).delete_all
  end
end