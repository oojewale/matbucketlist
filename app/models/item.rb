class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates :name, presence: true, length: { minimum: 3 }
  validates :bucketlist_id, presence: true

  def self.get_item_owner(id)
    Item.find(id).bucketlist.created_by
  end

  def self.update_item(info)
    if info[:status] == true
      find(info[:id]).update(name: info[:new_name], done: info[:status])
    else
      find(info[:id]).update(name: info[:new_name])
    end
  end
end
