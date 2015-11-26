class AddColumnBlacklistedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blacklisted, :boolean
    change_column_default :users, :blacklisted, false
  end
end
