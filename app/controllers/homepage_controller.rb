class HomepageController < ApplicationController
  before_action :check_session, only: %i[profile_list exit_profile_list]

  def home
  end

  def museum
  end

  def search
    if params[:query].present?
      @teachers = Teacher.where('fio LIKE ?', "#{params[:query]}%").sort_by(&:fio)
    else
      @teachers = Teacher.all.sort_by(&:fio)
    end

    if turbo_frame_request?
      render partial: 'teachers'
    else
      render :teachers
    end
  end

  def get_image
    send_file("#{Rails.root}/app/assets/images/" + params[:path] + '.' + params[:format], disposition: 'inline')
  end

  def materials
  end

  def teachers
    @teachers = Teacher.all.sort_by(&:fio)
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
