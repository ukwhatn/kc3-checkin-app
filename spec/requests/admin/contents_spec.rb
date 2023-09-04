require "rails_helper"

RSpec.describe "Admin::Contents", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/admin/contents/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/contents/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/contents/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
