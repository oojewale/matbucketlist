class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates :name, presence: true, length: { minimum: 3 }
  validates :created_by, presence: true
end