class Bucketlist < ActiveRecord::Base
  has_one :user
  has_many :items
  validates :name, presence: true
  validates :done, presence: true
  validates :bucketlist_id, presence: true
end
