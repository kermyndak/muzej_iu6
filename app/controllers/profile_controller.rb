class ProfileController < ApplicationController
  before_action :check_admin, only: :admin_profile
  before_action :get_user_id, only: %i[set_admin edit change update]
  def admin_profile
    @users = User.where.not(role: 'admin')
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
    turbo_stream.update('role', partial: 'change_role')
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

  def get_user_id
    @user_id = params[:id].to_i
  end
end
