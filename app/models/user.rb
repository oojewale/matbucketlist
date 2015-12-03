class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, length: { minimum: 8 }
  has_secure_password

  def get_by_page(page, limit = nil)
    if limit.nil?
      limit = 20
    elsif limit.to_i > 100
      limit = 100
    end
    limit = limit.to_i
    offset = (page.to_i - 1) * limit
    bucketlists.offset(offset).limit(limit)
  end

  def generate_auth_token(flag = nil)
    payload = { user_id: id }
    return Api::V1::Tokenizer.encode(payload, 4.minutes.from_now) unless
    flag.nil?
    Api::V1::Tokenizer.encode(payload)
  end

  def self.find_by_credentials(username, password)
    find_by(username: username).try(:authenticate, password)
  end
end
