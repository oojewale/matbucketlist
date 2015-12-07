require "rails_helper"

RSpec.describe User, type: :model do
  subject(:user) { User.new(username: name, password: password) }
  let(:name) { "messi" }
  let(:password) { "asdfghjkl" }
  let(:existing_user) { User.first }
  before do
    user.save
  end

  describe ".get_by_page" do
    it "returns user bucketlists by page" do
      expect(user.get_by_page(1, 1)).to be_an ActiveRecord::AssociationRelation
    end

    it "returns user bucketlists by page" do
      expect(user.get_by_page(1)).to be_an ActiveRecord::AssociationRelation
    end

    it "returns user bucketlists by page" do
      expect(user.get_by_page(1, 101)).to be_an ActiveRecord::
      AssociationRelation
    end
  end

  describe ".find_by_credentials" do
    it "authenticates a user" do
      expect(User.find_by_credentials(name, password)).to be_a User
    end
  end

  describe "#generate_auth_token" do
    it "generates auth token for user" do
      expect(user.generate_auth_token).to be_a String
    end
  end

  describe "check relation with bucketlist" do
    it "returns user bucketlist" do
      expect(existing_user.bucketlists.count).to eq(1)
    end
  end

  describe "checks for username in user creation" do
    let(:name) { nil }
    it "does not save without name" do
      expect { user.save }.not_to change(User, :count)
    end
  end

  describe "checks for username length" do
    let(:name) { "ab" }
    it "does not save when username is less than 3 characters" do
      expect { user.save }.not_to change(User, :count)
    end
  end

  describe "checks for password in user creation" do
    let(:password) { nil }
    it "does not save without password" do
      expect { user.save }.not_to change(User, :count)
    end
  end
end
