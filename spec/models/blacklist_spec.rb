require "rails_helper"

RSpec.describe Blacklist, type: :model do
  subject(:blacklist) { Blacklist.new(encrypted_token: token) }
  let(:token) { "qweaseeasscdcddefewfewfeefeewf" }

  describe "#delete_record" do
    it "deletes a blacklist" do
      blacklist.save
      expect { blacklist.delete_old }.not_to change(Blacklist, :count)
    end
  end
end
