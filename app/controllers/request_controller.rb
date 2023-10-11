class RequestController < ApplicationController
  before_action :check_session
  before_action :check_admin, only: %i[admin read already_read add_files]
  before_action :get_request_id, only: %i[read]
  before_action :check_id, only: %i[]
  before_action :read_param, only: :read

  def send_request
  end

  def admin
    @requests = Request.where.not(read: true)
  end

  def already_read
    @requests = Request.where.not(read: false)
  end

  def read
    request = Request.find(@request_id)
    @images.each do |key, _value| 
      request.images_blobs.find(key).update_column(:success, true)
    end unless @images.nil?

    @some_files.each do |key, _value| 
      request.some_files_blobs.find(key).update_column(:success, true)
    end unless @some_files.nil?
    request.update_column(:read, true)
    render turbo_stream: turbo_stream.remove("card_#{@request_id}")
  end

  def create # should be validate
    @request = Request.new(request_params)
    @request.user_id = current_user.id
    if current_user.role == 'admin'
      @request.read = true
    end
    @request.save!
  end

  def add_files
  end

  private
  def check_admin
    if current_user.role != 'admin'
      redirect_to root_path
    end
  end

  def get_request_id
    @request_id = params[:id].to_i
  end

  def read_param
    @images = params[:image]
    @some_files = params[:file]
    unless @images.nil?
      @images.select! {|_key, value| value == '1'}
    end

    unless @files.nil?
      @some_files.select! {|_key, value| value == '1'}
    end
  end

  def check_id
    if current_user.role != 'admin' && current_user.id != @user_id
      redirect_to root_path
    end
  end

  def request_params
    params.permit(:message, images: [], some_files: [])  
  end
end
