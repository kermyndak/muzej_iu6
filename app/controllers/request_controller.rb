class RequestController < ApplicationController
  before_action :check_admin, only: %i[admin]
  before_action :get_user_id, only: %i[]
  before_action :check_id, only: %i[send]

  def send_request
  end

  def admin
    @requests = Request.all
  end

  def create
    @request = Request.new(request_params)
    @request.user_id = current_user.id

    @request.save!
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

  def check_id
    if current_user.role != 'admin' && current_user.id != @user_id
      redirect_to root_path
    end
  end

  def request_params
    params.permit(:message, images: [], files: [])
  end
end
