class CreateBlacklists < ActiveRecord::Migration
  def change
    create_table :blacklists do |t|
      t.string :encrypted_token

      t.timestamps null: false
    end
  end
end
