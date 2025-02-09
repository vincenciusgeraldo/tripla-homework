require 'rails_helper'

RSpec.describe AuthController, type: :controller do
  describe "POST #login" do
    let(:user) { create(:user) }
    let(:valid_params) { { user_id: user.id } }
    let(:invalid_params) { { user_id: nil } }

    it "returns a token for valid user_id" do
      post :login, params: valid_params
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to have_key("token")
    end

    it "returns an error for invalid user_id" do
      post :login, params: invalid_params
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns an error for missing user_id" do
      post :login, params: {}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
