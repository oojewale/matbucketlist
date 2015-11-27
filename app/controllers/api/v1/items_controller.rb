class Api::V1::ItemsController < ApplicationController
  before_action :item_owner?, only: [:update, :destroy]

  include Commons

  def create
    if @current_user.bucketlists.find(params[:id])
      info = { bucketlist_id: params[:id], name: params[:name] }
      item = Item.new(info)
      model_obj_saver(item)
    end
  rescue
    render json: { error: "User does not have bucketlist with id: #{params[:id]}" }, status: 403
  end

  def update
      info = { :new_name => params[:new_name], id: params[:id], status: params[:status] }
      if Item.update_item(info)
        render json: { response: "Item updated!" }, status: 200
      end
  rescue
    render json: { error: "Could not update bucketlist item." }, status: 304
  end

  def destroy
      render json: { response: "Bucketlist item deleted" }, status: 410 if
      Item.delete(params[:id])
  rescue
    render json: { error: "Could not delete bucketlist item with  id: #{params[:id]}." }, status: 500
  end

  protected

  def item_owner?
    @current_user.id == Item.get_item_owner(params[:id])
  end

end
