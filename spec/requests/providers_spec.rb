require 'rails_helper'

RSpec.describe "Providers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/providers/index"
      expect(response).to have_http_status(:success)
    end
  end

end
