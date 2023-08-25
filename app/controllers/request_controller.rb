class RequestController < ApplicationController
  before_action :check_admin, only: %i[admin read already_read]
  before_action :get_request_id, only: %i[read]
  before_action :check_id, only: %i[send]
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
    @images.each { |key, _value| request.images_blobs
                                        .find(key)
                                        .update_column(:success, true) } unless @images.nil?
    p @images
    @files.each { |key, _value| request.files_blobs
                                       .find(key)
                                       .update_column(:success, true) } unless @files.nil?
    request.update_column(:read, true)
    render turbo_stream: turbo_stream.remove("card_#{@request_id}")
  end

  def create # should be validate
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

  def get_request_id
    @request_id = params[:id].to_i
  end

  def read_param
    @images = params[:image]
    @files = params[:file]
    unless @images.nil?
      @images.select! {|_key, value| value == '1'}
    end

    unless @files.nil?
      @files.select! {|_key, value| value == '1'}
    end
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
