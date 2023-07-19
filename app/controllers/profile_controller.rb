class ProfileController < ApplicationController
  before_action :check_admin, only: %i[admin_profile set_admin update change edit]
  before_action :get_user_id, only: %i[set_admin edit change update]
  def admin_profile
    # @users = User.where.not(role: 'admin')
    @users = User.where.not(email: 'admin@admin.ru')
    # @users = User.all
  end

  def profile
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

  def edit
    @user = User.find(@user_id)
  end

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

  def change_role
  end

  private
  def check_admin
    if current_user.role != 'admin'
      redirect_to root_path
    end
  end

  def get_edit_params
    params.permit(:name, :surname, :middle_name, :year)
  end

  def get_update_params
    @user = User.find(@user_id)
    params.permit(:field, :name, :surname, :middle_name, :year)
  end

  def get_user_id
    @user_id = params[:id].to_i
  end
end
