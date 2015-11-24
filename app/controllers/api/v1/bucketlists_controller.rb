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
    info = { name: params[:name], created_by: decoded_auth_token[:user_id]}
    bucket = Bucketlist.new(info)
    if bucket.save
      render json: { response: "Bucketlist created" }, status: :created
    else
      render json: { error: "Could not create bucketlist" }, status: 501
    end
  end

  def show
    user_id = decoded_auth_token[:user_id]
    bucket_data = User.get_user_bucketlist_items(user_id, "id", params[:id])
    render json: bucket_data, root: false
  rescue
    render json: [], status: 401
  end

  def edit
  end

  def update
    info = { user_id: decoded_auth_token[:user_id], id: params[:id], new_name: params[:new_name] }
    if User.update_bucketlist(info)
      render json: { response: "Bucketlist updated!" }, status: 200
    end
  rescue
    render json: { error: "Could not update bucketlist" }, status: 501
  end

  def destroy
    user_id = decoded_auth_token[:user_id]
    render json: { response: "Bucketlist deleted" } if User.delete_bucketlist(user_id, params[:id])
  rescue
    render json: { error: "Could not delete bucketlist with  id: #{params[:id]}." }, status: 500
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