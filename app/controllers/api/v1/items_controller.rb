module Api
  module V1
    class ItemsController < ApplicationController
      include Commons
      include Booleanizer

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

      def show
        if item_owner?
          item = Item.find(permitted[:id])
          render json: item, root: false
        else
          render json: { error: "You have no access to this item" } , status: 403
        end
      rescue
        render json: { error: "Bucketlist and item mismatch." },
               status: 401
      end

      def update
        if item_owner?
          info = { name: permitted[:name], id: permitted[:id],
                   status: permitted[:status].to_b }
          if Item.update_item(info)
            render json: { response: "Item updated!" }, status: 200
          end
        else
          render json: { error: "Bucketlist and item mismatch." },
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
          render json: { error: "Bucketlist and item mismatch." },
                 status: 401
        end
      rescue
        render json: { error: "Could not delete bucketlist item with  id:
                       #{permitted[:id]}." }, status: 500
      end

      protected

      def item_owner?
        item_id = permitted[:id]
        bucket_id = permitted[:bucketlist_id].to_i
        if bucket_id == Item.get_item_bucket_id(item_id)
          @current_user.id == Bucketlist.find(bucket_id).created_by
        end
      end
    end
  end
end
