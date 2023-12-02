class AdminController < ApplicationController
  before_action :check_session
  before_action :check_admin
  before_action :get_user_id, only: %i[set_admin edit]

  def users
    @users = User.where.not(email: 'admin@admin.ru').select(&:confirmed?)
  end

  def set_admin
    @user = User.find(@user_id)
    if @user.role == 'user'
      @user.update_column(:role, 'admin')
    else
      @user.update_column(:role, 'user')
    end
    render partial: 'admin'
  end

  def edit_teacher
    @teacher = Teacher.find(params[:id])
  end

  def edit
    @user = User.find(@user_id)
  end

  def add_teacher
  end

  def create_teacher
    teacher = Teacher.new(teacher_params)
    teacher.save!
    render turbo_stream: turbo_stream.replace('teacher_send_form', partial: 'teacher_send_form')
  end

  def update_teacher
    teacher = Teacher.find(params[:id])
    teacher.image.delete
    teacher.delete
    teacher = Teacher.new(teacher_params)
    teacher.id = params[:id]
    teacher.save
    redirect_to list_teachers_url
  end

  def list_teachers
    @teachers = Teacher.all.sort_by(&:fio)
  end

  def add_users
  end

  def create_users
    @user = User.new
    @password = @user.generate_password(true)
    @user.create_user_without_confirmation(get_user_params)
    MailerJob.perform_later(current_user, @user, @password)
    render turbo_stream: turbo_stream.append('users', partial: 'new_user')
  end

  def clean_users_without_confirmation
    CheckConfirmationJob.perform_later(current_user)
    render turbo_stream: turbo_stream.append('clean-block', "Запрос отправлен")
  end

  private
  def check_admin
    if current_user.role != 'admin'
      redirect_to root_path
    end
  end

  def get_user_id
    @user_id = params[:id].to_i
  end

  def get_user_params
    params.permit(:email, :name, :surname, :middle_name, :year)
  end

  def teacher_params
    params.permit(:fio, :job_title, :additional_information, :image)
  end
end
