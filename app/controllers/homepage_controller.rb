class HomepageController < ApplicationController
  before_action :check_session, only: %i[profile_list exit_profile_list]

  def home
  end

  def museum
  end

  def materials
  end

  def teachers
  end

  def history
  end

  def profile_list
    render partial: 'profile_list'
  end

  def exit_profile_list
    render partial: 'up_frame'
  end
end
