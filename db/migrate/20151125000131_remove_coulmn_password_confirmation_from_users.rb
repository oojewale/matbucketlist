class RemoveCoulmnPasswordConfirmationFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :password_confirmation, :string
  end
end
