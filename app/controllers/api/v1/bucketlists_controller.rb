class Api::V1::BucketlistsController < ApplicationController

  include Commons

  def index
    render json: params_processor(params), root: false
  rescue
    render json: [], root: false
  end

  def create
    info = { name: params[:name], created_by: @current_user.id}
    bucket = Bucketlist.new(info)
    model_obj_saver(bucket)
  end

  def show
    bucket_data = @current_user.bucketlists.find(params[:id])
    render json: bucket_data, root: false
  rescue
    render json: [], status: 403
  end

  def update
    id = params[:id]
    name = params[:new_name]
    if @current_user.bucketlists.find(id).update(name: name)
      render json: { response: "Bucketlist updated!" }, status: 200
    end
  rescue
    render json: { error: "Could not update bucketlist" }, status: 304
  end

  def destroy
    render json: { response: "Bucketlist deleted" }, status: 410 if
    @current_user.bucketlists.delete(params[:id])
  rescue
    render json: { error: "Could not delete bucketlist with  id: #{params[:id]}." }, status: 500
  end

  protected

  def numeric?(item)
    /\d+/.match("#{item}")
  end

  def params_processor(params)
    if params.count == 2
      @current_user.bucketlists
    elsif params[:q]
      @current_user.bucketlists.find_by(name: params[:q])
    elsif page_limiter(params[:page], params[:limit])
      @current_user.get_by_page(params[:page], params[:limit])
    end
  end

  def page_limiter(page, limit)
    numeric?(page) && (numeric?(limit) || limit.nil?)
  end
end
