class HomepageController < ApplicationController
  before_action :check_session, only: %i[profile_list exit_profile_list]

  def home
  end

  def museum
  end

  def materials
  end

  def teachers
    @teachers = Teacher.all
  end

  def history
  end

  def profile_list
    render turbo_stream: turbo_stream.update('profile', partial: 'profile_list')
  end

  def exit_profile_list
    render turbo_stream: turbo_stream.update('profile', '<a href="/homepage/profile_list">Профиль</a>')
  end
end
