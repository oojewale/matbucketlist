class Api::V1::ItemsController < ApplicationController

  def create
    if User.bucket_belong_to_user(decoded_auth_token[:user_id], params[:id])
      info = { bucketlist_id: params[:id], name: params[:name] }
      item = Item.new(info)
      item_saver(item)
    end
  rescue
    render json: { error: "User does not have bucketlist with id: #{params[:id]}" }, status: 401
  end

  def update
  end

  def delete
  end

  protected

  def item_saver(item)
    if item.save
      render json: { response: "Item created" }, status: :created
    else
      render json: { error: "Could not create item" }, status: 501
    end
  end

end
