class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true
  has_secure_password

  def self.get_user_bucketlist_items(user_id, column = nil, value = nil)
    if column.nil? || value.nil?
      where(id: user_id).first.bucketlists
    else
      where(id: user_id).first.bucketlists.where(name: value)
    end
  end

  def self.get_by_page(user_id, page, limit)
    limit = limit.to_i
    offset = (page.to_i - 1) * limit
    where(id: user_id).first.bucketlists.offset(offset).limit(limit)
  end

  def generate_auth_token
    payload = { user_id: self.id }
    Api::V1::Tokenizer.encode(payload)
  end

  def self.find_by_credentials(username, password)
    find_by(username: username).try(:authenticate, password)
  end

end