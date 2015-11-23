class Bucketlist < ActiveRecord::Base
  belongs_to :user
  has_many :items
  validates :name, presence: true
  validates :created_by, presence: true

  # def self.get_bucketlist(column, value)
  #   my_bucket = Bucketlist.where("#{column}": value).first
  #   my_items = my_bucket.items
  #   [my_bucket, my_items]
  # end

  def self.get_by_page(page, limit)
    limit = limit.to_i
    offset = (page.to_i - 1) * limit
    Bucketlist.offset(offset).limit(limit)
  end


end
