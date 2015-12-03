class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates :name, presence: true, length: { minimum: 3 }
  validates :bucketlist_id, presence: true

  def self.get_item_owner(id)
    Item.find(id).bucketlist.created_by
  end

  def self.get_item_bucket(id)
    Item.find(id).bucketlist.id
  end

  def self.update_item(info)
    if info[:status] == "true"
      find(info[:id]).update(name: info[:name], done: true)
    elsif info[:status] == "false"
      find(info[:id]).update(name: info[:name], done: false)
    else
      find(info[:id]).update(name: info[:name])
    end
  end
end
