class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true
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
    limit = limit.to_i
    offset = (page.to_i - 1) * limit
    find(user_id).bucketlists.offset(offset).limit(limit)
  end

  def self.update_bucketlist(info)
    find(info[:user_id]).bucketlists.find(info[:id]).update(name: info[:new_name])
  end

  def generate_auth_token
    payload = { user_id: id }
    Api::V1::Tokenizer.encode(payload)
  end

  def self.find_by_credentials(username, password)
    find_by(username: username).try(:authenticate, password)
  end

end