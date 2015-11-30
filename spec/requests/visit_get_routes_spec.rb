require "rails_helper"

RSpec.describe "Visit get routes after login", type: :request do
  # subject(:user) {User.new(username: username, password: password)}
  # let(:username) { "carzola" }
  # let(:password)   { "asdfghjkl" }
  # let(:token) { user.generate_auth_token }
  # before do
  #   user.save
  # end

  let(:user) { User.first }
  let(:token) { user.generate_auth_token }

  describe "GET #logout" do
    it "logs user out" do
      get "/api/v1/auth/logout", {}, { "Accept" => "application/json", "Authorization" => token }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "fetches all user bucketlists" do
      get "/api/v1/bucketlists", {}, { "Accept" => "application/json", "Authorization" => token }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do


    it "fetches all user bucketlists" do
      get "/api/v1/bucketlists", {q: "Life events"}, { "Accept" => "application/json", "Authorization" => token }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "fetches all user bucketlists" do
      get "/api/v1/bucketlists", { page: 1, limit: 1 }, { "Accept" => "application/json", "Authorization" => token }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET #bucketlists" do
    it "fetches all user bucketlists" do
      get "/api/v1/bucketlists", { q: "Endless events" }, { "Accept" => "application/json", "Authorization" => token }
      expect(response).to have_http_status(200)
    end
  end

  # describe "GET #token_expires" do
  #   it "token expires" do
  #     raw_token = Api::V1::Tokenizer.decode(token)
  #     raw_token["exp"] = Time.now
  #     tokenz = Api::V1::Tokenizer.encode(raw_token)
  #     get "/api/v1/bucketlists", {}, { "Accept" => "application/json", "Authorization" => token }
  #       require "pry"; binding.pry
  #     expect(response).to have_http_status(403)
  #   end
  # end

end