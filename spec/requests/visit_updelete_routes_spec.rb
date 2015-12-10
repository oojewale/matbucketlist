require "rails_helper"

RSpec.describe "Visit post routes after login", type: :request do
  let(:user) { User.first }
  let(:token) { user.generate_auth_token }
  let(:invalid_status) { "asads" }

  describe "PUT #update_item" do
    it "updates item with true status to mark it as done" do
      put "/api/v1/bucketlists/1/items/1", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
      expect(message(response)).to include("Item updated!")
    end
  end

  describe "PUT #update_item" do
    it "updates item with false status" do
      put "/api/v1/bucketlists/1/items/1", { name: "Play EPL", status: false },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
      expect(message(response)).to include("Item updated!")
    end
  end

  describe "PUT #update_item" do
    it "updates item without status" do
      put "/api/v1/bucketlists/1/items/1", { name: "Play EPL" },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
      expect(message(response)).to include("Item updated!")
    end
  end

  describe "PUT #update_item" do
    it "updates item and done status defaults to false" do
      put "/api/v1/bucketlists/1/items/1", { name: "Play EPL",
                                             status: invalid_status },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
      expect(message(response)).to include("Item updated!")
    end
  end

  describe "PUT #update_item" do
    it "updates item fails for invalid item id" do
      put "/api/v1/bucketlists/1/items/2", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(401)
      expect(message(response)).to include("Bucketlist and item mismatch")
    end
  end

  describe "PUT #update_item" do
    it "updates item fails for invalid bucketlist_id" do
      put "/api/v1/bucketlists/10/items/9", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
      expect(message(response)).to include("Could not update bucketlist item")
    end
  end

  describe "PUT #update_bucketlist" do
    it "updates bucketlist" do
      put "/api/v1/bucketlists/1", { name: "Life eventX" },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
      expect(message(response)).to include("Bucketlist updated!")
    end
  end

  describe "PUT #update_bucketlist" do
    it "updates bucketlist fails" do
      put "/api/v1/bucketlists/10", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
      expect(message(response)).to include("Could not update bucketlist")
    end
  end

  describe "DELETE #bucketlist" do
    it "delete bucketlist" do
      delete "/api/v1/bucketlists/1", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(410)
      expect(message(response)).to include("Bucketlist deleted")
    end
  end

  describe "DELETE #bucketlist" do
    it "delete bucketlist fails" do
      delete "/api/v1/bucketlists/10", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
      expect(message(response)).to include("Could not delete bucketlist")
    end
  end

  describe "DELETE #item" do
    it "delete item from bucketlist" do
      delete "/api/v1/bucketlists/1/items/1", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(410)
      expect(message(response)).to include("Bucketlist item deleted")
    end
  end

  describe "DELETE #item" do
    it "delete item from incorrect bucketlist fails" do
      delete "/api/v1/bucketlists/1/items/2", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(401)
      expect(message(response)).to include("Bucketlist and item mismatch")
    end
  end

  describe "DELETE #item" do
    it "delete item from bucketlist fails" do
      delete "/api/v1/bucketlists/0/items/10", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
      expect(message(response)).to include("Could not delete bucketlist item")
    end
  end
end
