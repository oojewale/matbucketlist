class RemoveColumnBlacklistedFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :blacklisted, :boolean
  end
end
