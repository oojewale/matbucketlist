require "rails_helper"

RSpec.describe Item, type: :model do
  subject(:item) { Item.new(name: name, done: status, bucketlist_id: bucket) }
  let(:name) { "my item" }
  let(:status) { false }
  let(:bucket) { Bucketlist.first.id }
  let(:id) { Item.first.id }

  describe "check relation with bucketlist" do
    it "returns item bucketlist" do
      item.save
      expect(item.bucketlist).to be_a Bucketlist
    end
  end

  describe "checks for bucketlist_id in item" do
    let(:bucket) { nil }
    it "does not save without bucketlist_id" do
      expect { item.save }.not_to change(Item, :count)
    end
  end

  describe "checks for item name length" do
    let(:name) { "ab" }
    it "does not save when item name is less than 3 characters" do
      expect { item.save }.not_to change(Item, :count)
    end
  end

  describe ".get_item_bucket_id" do
    it "returns item bucketlist" do
      expect(Item.get_item_bucket_id(id)).to eq(1)
    end
  end

  describe ".update_item" do
    let(:status) { "false" }
    it "updates item" do
      info = { id: id, name: name, status: status }
      expect(Item.update_item(info)).to be true
    end
  end

  describe ".update_item" do
    let(:status) { "true" }
    it "updates item" do
      info = { id: id, name: name, status: status }
      expect(Item.update_item(info)).to be true
    end

    it "updates item" do
      info = { id: id, name: name }
      expect(Item.update_item(info)).to be true
    end
  end
end
