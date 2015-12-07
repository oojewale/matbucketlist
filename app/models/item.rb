class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates :name, presence: true, length: { minimum: 3 }
  validates :bucketlist_id, presence: true

  def self.get_item_bucket_id(id)
    Item.find(id).bucketlist_id
  end

  def self.update_item(info)
    return find(info[:id]).update(name: info[:name], done: true) if
      info[:status] == true
    return find(info[:id]).update(name: info[:name], done: false) if
      info[:status] == false
    find(info[:id]).update(name: info[:name])
  end
end
