class User < ActiveRecord::Base
  has_many :bucketlists, foreign_key: "created_by"
  validates :username, presence: true, uniqueness: true, length: { minimum: 3 }
  validates :password, length: { minimum: 8 }
  has_secure_password

  def get_by_page(page, limit = nil)
    if limit.nil?
      limit = ENV["MINIMUM_BUCKETS_PER_PAGE"].to_i
    elsif limit.to_i > ENV["MAXIMUM_BUCKETS_PER_PAGE"].to_i
      limit = ENV["MAXIMUM_BUCKETS_PER_PAGE"].to_i
    end
    limit = limit.to_i
    offset = (page.to_i - 1) * limit
    bucketlists.offset(offset).limit(limit)
  end

  def generate_auth_token(flag = nil)
    payload = { user_id: id }
    return Api::Tokenizer.encode(payload, 4.minutes.ago) unless
      flag.nil?
    Api::Tokenizer.encode(payload)
  end

  def self.find_by_credentials(username, password)
    find_by(username: username).try(:authenticate, password)
  end
end
