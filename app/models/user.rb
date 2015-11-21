class User < ActiveRecord::Base
  has_one :bucketlist, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true
end
