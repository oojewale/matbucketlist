require "rails_helper"

RSpec.describe "Visit post routes after login", type: :request do
  let(:user) { User.first }
  let(:token) { user.generate_auth_token }

  describe "PUT #update_item" do
    it "updates item" do
      put "/api/v1/bucketlists/1/items/1", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT #update_item" do
    it "updates item fails" do
      put "/api/v1/bucketlists/1/items/2", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(401)
    end
  end

  describe "PUT #update_item" do
    it "updates item fails" do
      put "/api/v1/bucketlists/10/items/9", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(304)
    end
  end

  describe "PUT #update_bucketlist" do
    it "updates bucketlist" do
      put "/api/v1/bucketlists/1", { name: "Life eventX" },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT #update_bucketlist" do
    it "updates bucketlist fails" do
      put "/api/v1/bucketlists/10", { name: "Play EPL", status: true },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(304)
    end
  end

  describe "DELETE #bucketlist" do
    it "delete bucketlist" do
      delete "/api/v1/bucketlists/1", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(410)
    end
  end

  describe "DELETE #bucketlist" do
    it "delete bucketlist fails" do
      delete "/api/v1/bucketlists/10", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(500)
    end
  end

  describe "DELETE #item" do
    it "delete item from bucketlist" do
      delete "/api/v1/bucketlists/1/items/1", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(410)
    end
  end

  describe "DELETE #item" do
    it "delete item from bucketlist fails" do
      delete "/api/v1/bucketlists/1/items/2", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(401)
    end
  end

  describe "DELETE #item" do
    it "delete item from bucketlist fails" do
      delete "/api/v1/bucketlists/0/items/10", {},
             "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(500)
    end
  end
end
