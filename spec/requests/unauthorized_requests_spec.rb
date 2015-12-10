require "rails_helper"

RSpec.describe "Unauthorized access", type: :request do
  describe "GET #logout" do
    it "returns 403" do
      get "/api/auth/logout", {}, "Accept" => "application/json"
      expect(response).to have_http_status(403)
      expect(message response).to include "Auth token is expired or not present"
    end
  end

  describe "GET #none_existing_route" do
    it "returns 404" do
      get "/api/v1/logouts", {}, "Accept" => "application/json"
      expect(response).to have_http_status(404)
      expect(message(response)).to include("Specified endpoint does not exist.")
    end
  end
end
