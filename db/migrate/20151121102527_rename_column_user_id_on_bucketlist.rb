class RenameColumnUserIdOnBucketlist < ActiveRecord::Migration
  def change
    rename_column :bucketlists, :user_id, :created_by
  end
end
