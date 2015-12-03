class Blacklist < ActiveRecord::Base
  validates :encrypted_token, presence: true, uniqueness: true
  before_create :delete_old

  def delete_old
    Blacklist.where("created_at <= ?", 12.hours.ago).delete_all
  end
end
