class HomepageController < ApplicationController
  before_action :set_cookie
  before_action :check_session, only: %i[profile_list exit_profile_list]

  def home
  end

  def museum
  end

  def search
    if params[:query].present?
      @teachers = Teacher.where('LOWER(fio) LIKE LOWER(?)', "#{params[:query]}%").sort_by(&:fio)
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
    if check_path(params[:path]) && !params[:format].nil?
      send_file("#{Rails.root}/app/assets/images/" + params[:path].gsub('|', '/') + '.' + params[:format], disposition: 'inline')
    else
      redirect_to root_path
    end
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

  private
  def check_path(path)
    if path.include?('..|')
      return false
    end
    true
  end
end
