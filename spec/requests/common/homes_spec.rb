require "rails_helper"

RSpec.describe "Common::Homes", type: :request do
  describe "GET /top" do
    it "returns http success" do
      get "/common/homes/top"
      expect(response).to have_http_status(:success)
    end
  end
end
