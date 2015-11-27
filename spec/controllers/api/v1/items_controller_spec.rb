require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do

  let(:user_id) { 1 }
  let(:id)   { 1 }
  let(:name)   { "play for Barca" }

  before do
    sample_data = Seeded.new
    sample_data.creator
  end

  describe "POST #create" do
    it "returns http success" do
      post :create, prefix: "/api/v1/bucketlists/1/items", user_id: user_id, id: id, name: name
      expect(response).to have_http_status(201)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #delete" do
    it "returns http success" do
      get :delete
      expect(response).to have_http_status(:success)
    end
  end

end
