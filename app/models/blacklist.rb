class Blacklist < ActiveRecord::Base
  validates :encrypted_token, presence: true, uniqueness: true

  def self.delete_old
    where("created_at <= ?", 12.hours.ago).delete_all
  end
end
