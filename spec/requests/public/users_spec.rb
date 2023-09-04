require "rails_helper"

RSpec.describe "Public::Users", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/public/users/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /confirm" do
    it "returns http success" do
      get "/public/users/confirm"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/public/users/show"
      expect(response).to have_http_status(:success)
    end
  end
end
