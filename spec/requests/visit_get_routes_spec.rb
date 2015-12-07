require "rails_helper"

RSpec.describe "Visit get routes after login", type: :request do
  let(:user) { User.first }
  let(:token) { user.generate_auth_token }

  describe "GET #logout" do
    it "logs user out" do
      get "/api/v1/auth/logout", {}, "Accept" => "application/json",
                                     "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #index" do
    it "root redirects user to API docementation" do
      get "/"
      expect(response).to have_http_status(302)
    end
  end

  describe "GET #bucketlists" do
    it "fetches all user bucketlists" do
      get "/api/v1/bucketlists", {}, "Accept" => "application/json",
                                     "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "fetches bucketlist with the specified name" do
      get "/api/v1/bucketlists", { q: "Life events" },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "paginates all user bucketlists" do
      get "/api/v1/bucketlists", { page: 1, limit: 1 },
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "fetches a specific bucketlist" do
      get "/api/v1/bucketlists/1", {}, "Accept" => "application/json",
                                       "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "raises an error response for inappropriate id type" do
      get "/api/v1/bucketlists/sdfdsdfdc", {},
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
    end
  end

  describe "GET #item" do
    it "fetches a specific bucketlist item" do
      get "/api/v1/bucketlists/1/items/1", {}, "Accept" => "application/json",
                                       "Authorization" => token
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #item" do
    it "raises an error response for inappropriate id type" do
      get "/api/v1/bucketlists/1/items/sdfdsdfdc", {},
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(401)
    end
  end

  describe "GET #item" do
    it "raises an error response for inappropriate id type" do
      get "/api/v1/bucketlists/sads/items/1", {},
          "Accept" => "application/json", "Authorization" => token
      expect(response).to have_http_status(403)
    end
  end

  describe "#generate_auth_token" do
    let(:token) { user.generate_auth_token("true") }
    it "generates auth token for user" do
      get "/api/v1/bucketlists", {}, "Accept" => "application/json",
                                     "Authorization" => token
      expect(response).to have_http_status(403)
    end
  end
end
