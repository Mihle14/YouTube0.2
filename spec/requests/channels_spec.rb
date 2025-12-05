require 'rails_helper'

RSpec.describe "Channels", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/channels/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/channels/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/channels/update"
      expect(response).to have_http_status(:success)
    end
  end

end
