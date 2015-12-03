module Api
  module V1
    class ItemsController < ApplicationController
      include Commons

      def create
        if @current_user.bucketlists.find(permitted[:bucketlist_id])
          info = { bucketlist_id: permitted[:bucketlist_id],
                   name: permitted[:name] }
          item = Item.new(info)
          model_obj_saver(item)
        end
      rescue
        render json: { error: "User does not have bucketlist with id:
                       #{permitted[:id]}" }, status: 403
      end

      def update
        if item_owner?
          info = { name: permitted[:name], id: permitted[:id],
                   status: permitted[:status] }
          if Item.update_item(info)
            render json: { response: "Item updated!" }, status: 200
          end
        else
          render json: { error: "Wrong bucketlist for specified item." },
                 status: 401
        end
      rescue
        render json: { error: "Could not update bucketlist item." },
               status: 304
      end

      def destroy
        if item_owner?
          render json: { response: "Bucketlist item deleted" }, status: 410 if
          Item.delete(permitted[:id])
        else
          render json: { error: "Wrong bucketlist for specified item." },
                 status: 401
        end
      rescue
        render json: { error: "Could not delete bucketlist item with  id:
                       #{permitted[:id]}." }, status: 500
      end

      protected

      def item_owner?
        item_id = permitted[:id]
        if @current_user.id == Item.get_item_owner(item_id)
          permitted[:bucketlist_id].to_i == Item.get_item_bucket(item_id)
        end
      end
    end
  end
end
