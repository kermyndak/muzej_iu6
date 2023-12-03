class StorageController < ApplicationController
  before_action :set_cookie
  before_action :check_session
  before_action :check_admin
  before_action :get_type, only: %i[change]

  def index
  end

  def change
    case @type
    when 'images'
      render turbo_stream: turbo_stream.update('container', partial: 'images')
    when 'videos'
      @requests = Request.all.reject { |request| request.links.empty? }
      render turbo_stream: turbo_stream.update('container', partial: 'videos')
    when 'messages'
      @requests = Request.all.reject { |request| request.message.empty? }
      render turbo_stream: turbo_stream.update('container', partial: 'messages')
    when 'other_files'
      render turbo_stream: turbo_stream.update('container', partial: 'other_files')
    else
      render turbo_stream: turbo_stream.update('container', "Bad url")
    end
  end

  private
  def get_type
    @type = params[:type]
  end

  def check_admin
    if current_user.role != 'admin'
      redirect_to root_path
    end
  end
end
