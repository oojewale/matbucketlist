class Api::V1::ItemsController < ApplicationController
  include Commons
  def create
    if User.bucket_belong_to_user(decoded_auth_token[:user_id], params[:id])
      info = { bucketlist_id: params[:id], name: params[:name] }
      item = Item.new(info)
      model_obj_saver(item)
    end
  rescue
    render json: { error: "User does not have bucketlist with id: #{params[:id]}" }, status: 401
  end

  def update

    if item_owner?(params[:id])
      info = { :new_name => params[:new_name], id: params[:id], status: params[:status] }
      if Item.update_item(info)
        render json: { response: "Item updated!" }, status: 200
      end
    end
  rescue
    render json: { error: "Could not update bucketlist item." }, status: 304
  end

  def destroy
    if item_owner?(params[:id])
      render json: { response: "Bucketlist item deleted" }, status: 410 if
      Item.delete(params[:id])
    end
  rescue
    render json: { error: "Could not delete bucketlist item with  id: #{params[:id]}." }, status: 500
  end

  protected

  def item_owner?(id)
    decoded_auth_token[:user_id] == Item.get_item_owner(id)
  end

end
