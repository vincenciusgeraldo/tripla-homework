require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:user) }
  let(:current_user) { create(:user) }
  let(:headers) { { Authorization: "Bearer random_token" } }

  before do
    allow(controller).to receive(:authenticate).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    request.headers.merge!(headers)
  end

  describe "POST #follow" do
    context "when not already following" do
      it "follows the user" do
        post :follow, params: { id: user.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("Followed")
      end
    end

    context "when already following" do
      before { user.followers.create!(user_id: user.id, follower_user_id: current_user.id) }

      it "returns conflict status" do
        post :follow, params: { id: user.id }
        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)["error"]).to eq("Already following")
      end
    end
  end

  describe "POST #unfollow" do
    context "when following" do
      before { user.followers.create!(user_id: user.id, follower_user_id: current_user.id) }

      it "unfollows the user" do
        post :unfollow, params: { id: user.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["message"]).to eq("Unfollowed")
      end
    end

    context "when not following" do
      it "returns conflict status" do
        post :unfollow, params: { id: user.id }
        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)["error"]).to eq("Not following")
      end
    end
  end
end
