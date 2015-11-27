require 'rails_helper'

RSpec.describe Item, type: :model do

  subject(:item) { Item.new(name: name, done: status, bucketlist_id: bucket) }
  let(:name) {"my item"}
  let(:status) {false}
  let(:bucket) {Bucketlist.first.id}
  let(:id) {Item.first.id}

  describe ".get_item_owner" do
    it "returns item owner" do
      expect(Item.get_item_owner(id)).to be_an Integer
    end
  end

  describe ".update_item" do
    let(:status) {"false"}
    it "updates item" do
      info = { id: id, new_name: name, status: status}
      expect(Item.update_item(info)).to be true
    end
  end

  describe ".update_item" do
    let(:status) {"true"}
    it "updates item" do
      info = { id: id, new_name: name, status: status}
      expect(Item.update_item(info)).to be true
    end

    it "updates item" do
      info = { id: id, new_name: name}
      expect(Item.update_item(info)).to be true
    end
  end

end
