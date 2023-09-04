require "rails_helper"

RSpec.describe "Admin::Timetables", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/admin/timetables/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/timetables/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/admin/timetables/edit"
      expect(response).to have_http_status(:success)
    end
  end
end
