require "rails_helper"

RSpec.describe Api::V1::AuthController, type: :controller do

  let(:username) { "ozil" }
  let(:password)   { "asdfghjkl" }

  describe "POST #login" do
    it "returns http success" do
      post :login, prefix: "/api/v1/auth", username: username, password: password
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #login" do
    let(:username) { "bolu" }
    it "returns http unauthenticated" do
      post :login, prefix: "/api/v1/auth", username: username, password: password
      expect(response).to have_http_status(401)
    end
  end

  # describe "GET #logout" do
  #   it "returns http success" do
  #     get :logout

  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "GET #logout" do
    it "returns http server error" do
      get :logout
      expect(response).to have_http_status(500)
    end
  end

end
