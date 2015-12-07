require "rails_helper"

RSpec.describe Bucketlist, type: :model do
  subject(:bucket) { Bucketlist.new(name: name, created_by: owner) }
  let(:existing_bucket) { Bucketlist.first }
  let(:name) { "my bucket" }
  let(:owner) { User.first.id }

  describe "check relation with user" do
    it "returns bucketlist creator" do
      expect(existing_bucket.created_by).to eq(1)
    end
  end

  describe "check relation with item" do
    it "returns bucketlist item" do
      expect(existing_bucket.items.count).to eq(3)
    end
  end

  describe "check relation with item on deletion" do
    it "deletes all associated bucketlist item" do
      existing_bucket.destroy
      expect(Item.count).to eq(2)
    end
  end

  describe "checks for name in bucketlist creation" do
    let(:name) { nil }
    it "does not save without name" do
      expect { bucket.save }.not_to change(Bucketlist, :count)
    end
  end

  describe "checks for bucketlist name length" do
    let(:name) { "ab" }
    it "does not save when bucketlist name is less than 3 characters" do
      expect { bucket.save }.not_to change(Bucketlist, :count)
    end
  end

  describe "checks for created_by in bucketlist creation" do
    let(:owner) { nil }
    it "does not save without created_by" do
      expect { bucket.save }.not_to change(Bucketlist, :count)
    end
  end

end
