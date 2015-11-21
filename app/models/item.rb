class Item < ActiveRecord::Base
  belongs_to :bucketlist
  validates :name, presence: true
  validates :user_id, presence: true
end
