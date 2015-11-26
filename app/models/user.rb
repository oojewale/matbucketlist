class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, length: { minimum: 8 }
  has_secure_password

  def self.get_user_bucketlist_items(user_id, column = nil, value = nil)
    if column.nil? || value.nil?
      find(user_id).bucketlists
    else
      find(user_id).bucketlists.where("#{column}": value)
    end
  end

  def self.delete_bucketlist(user_id, id)
    find(user_id).bucketlists.delete(id)
  end

  def self.get_by_page(user_id, page, limit)
    if limit.nil?
      limit = 20
    elsif limit.to_i > 100
      limit = 100
    end
    limit = limit.to_i
    offset = (page.to_i - 1) * limit
    find(user_id).bucketlists.offset(offset).limit(limit)
  end

  def self.update_bucketlist(info)
    find(info[:user_id]).bucketlists.find(info[:id]).update(name: info[:new_name])
  end

  def generate_auth_token
    payload = { user_id: id, active: true }
    Api::V1::Tokenizer.encode(payload)
  end

  def self.deactivate_auth_token(id)
    payload = { user_id: id, active: false }
    Api::V1::Tokenizer.encode(payload)
  end

  def self.find_by_credentials(username, password)
    find_by(username: username).try(:authenticate, password)
  end

  def self.bucket_belong_to_user(user_token, bucket_id)
    find(user_token).bucketlists.find(bucket_id)
  end
end
