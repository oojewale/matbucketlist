class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.boolean :done
      t.integer :bucketlist_id

      t.timestamps null: false
    end
  end
end
