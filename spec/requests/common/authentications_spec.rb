require "rails_helper"

RSpec.describe "Common::Authentications", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/common/authentications/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /token" do
    it "returns http success" do
      get "/common/authentications/token"
      expect(response).to have_http_status(:success)
    end
  end
end
