class RequestController < ApplicationController
  before_action :check
  def index
  end

  private
  def check
    if current_user.role != 'admin'
      redirect_to root_path
    end
  end
end
