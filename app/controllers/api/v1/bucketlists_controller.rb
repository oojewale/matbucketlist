class Api::V1::BucketlistsController < ApplicationController

  include Commons

  def index
    render json: params_processor(permitted), root: false
  rescue
    render json: [], root: false
  end

  def create
    info = { name: permitted[:name], created_by: @current_user.id}
    bucket = Bucketlist.new(info)
    model_obj_saver(bucket)
  end

  def show
    bucket_data = @current_user.bucketlists.find(permitted[:id])
    render json: bucket_data, root: false
  rescue
    render json: [], status: 403
  end

  def update
    id = permitted[:id]
    name = permitted[:name]
    if @current_user.bucketlists.find(id).update(name: name)
      render json: { response: "Bucketlist updated!" }, status: 200
    end
  rescue
    render json: { error: "Could not update bucketlist" }, status: 304
  end

  def destroy
    render json: { response: "Bucketlist deleted" }, status: 410 if
    @current_user.bucketlists.delete(permitted[:id])
  rescue
    render json: { error: "Could not delete bucketlist with  id: #{permitted[:id]}." }, status: 500
  end

  protected

  def numeric?(item)
    /\d+/.match("#{item}")
  end

  def params_processor(permitted)
    if permitted.empty?
      @current_user.bucketlists
    elsif permitted[:q]
      @current_user.bucketlists.find_by(name: permitted[:q])
    elsif page_limiter(permitted[:page], permitted[:limit])
      @current_user.get_by_page(permitted[:page], permitted[:limit])
    end
  end

  def page_limiter(page, limit)
    numeric?(page) && (numeric?(limit) || limit.nil?)
  end
end
