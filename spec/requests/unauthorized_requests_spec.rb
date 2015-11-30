require "rails_helper"

RSpec.describe "Unauthorized access", type: :request do

  describe "GET #logout" do
    it "returns 401" do
      get "/api/v1/auth/logout", {}, { "Accept" => "application/json" }
      expect(response).to have_http_status(401)
      body = JSON.parse(response.body)
      message = body["error"]
      expect(message).to match("Not Authenticated")
    end
  end

  describe "GET #none_existing_route" do
    it "returns 404" do
      get "/api/v1/logouts", {}, { "Accept" => "application/json" }
      expect(response).to have_http_status(404)
      body = JSON.parse(response.body)
      message = body["error"]
      expect(message).to include("Specified endpoint does not exist.")
    end
  end



end