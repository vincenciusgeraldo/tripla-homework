require 'rails_helper'

RSpec.describe SleepTrackersController, type: :controller do
  let(:current_user) { create(:user) }
  let(:sleep_tracker) { create(:sleep_tracker, user: current_user, sleep_at: Time.current, awake_at: Time.current) }

  before do
    allow(controller).to receive(:authenticate).and_return(true)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    allow(controller).to receive(:set_sleep_tracker).and_return(sleep_tracker)
    allow(controller).to receive(:sleep_tracker).and_return(sleep_tracker)
  end

  describe "POST #record_sleep" do
    context "when sleep record is already recorded" do
      before { sleep_tracker.update(awake_at: nil) }

      it "returns conflict status" do
        post :record_sleep
        expect(response).to have_http_status(:conflict)
        expect(JSON.parse(response.body)["error"]).to eq("Sleep record is already recorded")
      end
    end

    context "when sleep record is not recorded" do
      before { sleep_tracker.update(awake_at: Time.current) }

      it "creates a new sleep record" do
        post :record_sleep
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)["data"]["user_id"]).to eq(current_user.id)
      end
    end
  end

  describe "POST #record_awake" do
    context "when sleep record exists" do
      before { sleep_tracker.update(awake_at: nil) }

      it "updates the sleep record with awake time" do
        post :record_awake
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)["data"]["awake_at"]).not_to be_nil
      end
    end

    context "when no sleep record found" do
      before { sleep_tracker.update(awake_at: Time.current) }

      it "returns not found status" do
        post :record_awake
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)["error"]).to eq("No sleep record found")
      end
    end
  end

  describe "GET #my_sleep_trackers" do
    let!(:sleep_trackers) { create_list(:sleep_tracker, 10, user: current_user, sleep_at: Time.current, awake_at: Time.current) }

    it "returns paginated sleep trackers" do
      get :my_sleep_trackers, params: { limit: 5, offset: 0 }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["data"].size).to eq(5)
      expect(JSON.parse(response.body)["data"].size).to be <= 5
    end
  end

  describe "GET #followers_sleep_trackers" do
    let(:follower_user) { create(:user) }
    let(:follower) { create(:follower, user: current_user, follower_user_id: follower_user.id) }
    let!(:follower_sleep_tracker) { create(:sleep_tracker, user: follower_user, sleep_at: Time.current, awake_at: nil) }

    before do
      current_user.followers << follower
    end

    it "returns sleep trackers of followers" do
      get :followers_sleep_trackers
      expect(response).to have_http_status(:ok)
    end
  end
end
