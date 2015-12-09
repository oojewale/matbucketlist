require "rails_helper"

RSpec.describe "Visit post routes after login", type: :request do
  let(:user) { User.first }
  let(:token) { user.generate_auth_token }
  let(:right_password) { "scscscd2223fdff" }
  let(:wrong_password) { "as34" }

  describe "POST #create_user" do
    it "creates new user" do
      post "/api/v1/users/create", { username: "Messi",
                                     password: right_password },
           "Accept" => "application/json"
      expect(response).to have_http_status(201)
      expect(message(response)).to include({ "user" => { "username" => "Messi" }})
    end
  end

  describe "POST #create_user" do
    it "doesnt creates new user with short password" do
      post "/api/v1/users/create", { username: "ozil",
                                     password: wrong_password },
           "Accept" => "application/json"
      expect(response).to have_http_status(501)
      expect(message(response)).to include("Could not create User")
    end
  end

  describe "POST #create_item" do
    it "creates new item" do
      post "/api/v1/bucketlists/1/items", { name: "An item" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(201)
      expect(message(response)).to include({ "item" => { "name" => "An item" }})
    end
  end

  describe "POST #create_item" do
    it "does not create new item for invalid bucketlist" do
      post "/api/v1/bucketlists/0/items", { name: "An item" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
      expect(message(response)).to include("User does not have bucketlist with id: 0")
    end
  end

  describe "POST #create_bucketlists" do
    it "creates new bucketlist" do
      post "/api/v1/bucketlists", { name: "A bucketlist" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(201)
      expect(message(response)).to include({ "bucketlist" => {"name" => "A bucketlist" }})
    end
  end

  describe "POST #create_bucketlists" do
    it "does not create bucketlist with an existing name" do
      post "/api/v1/bucketlists", { names: "A bucketlist" },
           "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(501)
      expect(message(response)).to include("Could not create Bucketlist")
    end
  end
end
