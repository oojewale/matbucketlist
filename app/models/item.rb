class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates :name, presence: true
  validates :bucketlist_id, presence: true
end
