require "rails_helper"

RSpec.describe "Visit post routes after login", type: :request do
  let(:user) { User.first }
  let(:token) { user.generate_auth_token }

  describe "POST #create_user" do
    it "creates new user" do
      post "/api/v1/users/create", { username: "Messi",
                                     password: "scscscdfdff" },
           "Accept" => "application/json"
      expect(response).to have_http_status(201)
    end
  end

  describe "POST #create_user" do
    it "creates new user" do
      post "/api/v1/users/create", { username: "ozil", password: 1234 },
           "Accept" => "application/json"
      expect(response).to have_http_status(501)
    end
  end

  describe "POST #create_item" do
    it "creates new item" do
      post "/api/v1/bucketlists/1/items", { name: "An item" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(201)
    end
  end

  describe "POST #create_item" do
    it "creates new item" do
      post "/api/v1/bucketlists/0/items", { name: "An item" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
    end
  end

  describe "POST #create_bucketlists" do
    it "creates new bucketlists" do
      post "/api/v1/bucketlists", { name: "A bucketlist" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(201)
    end
  end

  describe "POST #create_bucketlists" do
    it "creates new bucketlists" do
      post "/api/v1/bucketlists", { names: "A bucketlist" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(501)
    end
  end
end
