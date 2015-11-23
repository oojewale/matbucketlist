class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true

  def self.get_all_bucketlists
    my_bucket = User.first.bucketlist
    my_items = my_bucket.items
    [my_bucket, my_items]
  end

  def self.get_user_bucketlist_items(column, value)
    my_bucket = User.where("#{column}": value).first.bucketlist
    my_items = my_bucket.items
    [my_bucket, my_items]
  end

end