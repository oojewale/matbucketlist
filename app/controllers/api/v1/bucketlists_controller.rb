class Api::V1::BucketlistsController < ApplicationController

  def index
    bucket_data = params_processor(params)
    render json: bucket_data, root: false
  rescue
    render json: [], root: false
  end

  def new
  end

  def create
  end

  def show
    bucket_data = Bucketlist.find(params[:id])
    render json: bucket_data, root: false
  rescue
    render json: [], root: false
  end

  def edit
  end

  def update
  end

  def destroy
  end

  protected

  def numeric?(item)
    /\d+/.match("#{item}")
  end

  def params_processor(params)
    user_id = decoded_auth_token[:user_id]
    if params.count == 2
      User.get_user_bucketlist_items(user_id)
    elsif params[:q]
      User.get_user_bucketlist_items(user_id, "name", params[:q])
    elsif numeric?(params[:page]) && numeric?(params[:limit])
      User.get_by_page(user_id, params[:page], params[:limit])
    end
  end

end