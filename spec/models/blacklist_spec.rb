require "rails_helper"

RSpec.describe Blacklist, type: :model do
  subject(:blacklist) { Blacklist.new(encrypted_token: token) }
  let(:user) { User.first }
  let(:token) { user.generate_auth_token }

  describe "#delete_record" do
    it "deletes a blacklist" do
      blacklist.save
      expect { blacklist.delete_old }.not_to change(Blacklist, :count)
    end
  end

  describe "#save without encrypted_token" do
    let(:blacklist) { Blacklist.create }
    it "does not save when encrypted_token is not present" do
      expect { blacklist.delete_old }.not_to change(Blacklist, :count)
    end
  end

  describe "#save with encrypted_token" do
    it "saves when encrypted_token is present" do
      expect { blacklist.save }.to change(Blacklist, :count)
    end
  end

end
