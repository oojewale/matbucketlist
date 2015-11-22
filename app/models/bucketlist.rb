class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates :name, presence: true
  validates :created_by, presence: true

  def self.get_bucketlist(column, value)
    my_bucket = Bucketlist.where("#{column}": value).first
    my_items = my_bucket.items
    [my_bucket, my_items]
  end

end
