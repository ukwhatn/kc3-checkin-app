require "rails_helper"

RSpec.describe "Api::V1::Events", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/events/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/events/show"
      expect(response).to have_http_status(:success)
    end
  end
end
