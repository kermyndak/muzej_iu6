class ProfileController < ApplicationController
  before_action :set_cookie
  before_action :check_session
  before_action :get_user_id, only: %i[change update confirm_destroy destroy cancel_destroy password_update]
  before_action :check_id, only: %i[change update confirm_destroy password_update]

  def change
    render partial: 'field'
  end

  # Update user
  def update
    parameters = get_update_params
    case parameters[:field]
    when 'name'
      @user.update_column(:name, parameters[:name])
      render partial: 'name_link'
    when 'surname'
      @user.update_column(:surname, parameters[:surname])
      render partial: 'surname_link'
    when 'middle_name'
      @user.update_column(:middle_name, parameters[:middle_name])
      render partial: 'middle_name_link'
    when 'year'
      @user.update_column(:year, parameters[:year])
      render partial: 'year_link'
    end
  end

  def destroy
    render partial: 'confirm_destroy'
  end

  def cancel_destroy
    render partial: 'destroy_button'
  end

  # Delete user
  def confirm_destroy
    User.destroy(@user_id)
    if current_user.id == @user_id
      render turbo_stream: turbo_stream.remove('button_delete')
    else
      render turbo_stream: turbo_stream.remove("card_#{@user_id}")
    end
  end

  def profile
  end

  def change_password
  end

  def password_update
    user = User.find(@user_id)
    unless user.change_password(get_change_password_parameters)
      @errors = user.errors.map(&:message)
      render turbo_stream: turbo_stream.update('error-messages', partial: 'error_messages')
    else
      # save session
      redirect_to '/profile'
    end
  end

  def settings
    render 'setting_colors'
  end

  private
  def check_id
    if current_user.role != 'admin' && current_user.id != @user_id
      redirect_to root_path
    end
  end

  def get_update_params
    @user = User.find(@user_id)
    params.permit(:field, :name, :surname, :middle_name, :year)
  end

  def get_user_id
    @user_id = params[:id].to_i
  end

  def get_change_password_parameters
    params.permit(:current_password, :password, :password_confirmation)
  end
end
