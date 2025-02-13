class SleepTrackersController < ApplicationController
  before_action :authenticate
  before_action :set_sleep_tracker, only: %i[record_awake record_sleep]

  attr_reader :sleep_tracker

  # POST /sleep-trackers/sleep
  def record_sleep
    if sleep_tracker.awake_at.nil?
      render json: { error: "Sleep record is already recorded" }, status: :conflict
      return
    end

    params = { user_id: current_user.id, sleep_at: Time.now }
    sleep_tracker = SleepTracker.new(params)
    if sleep_tracker.save
      render json: { data: sleep_tracker }, status: :created
    else
      render json: { error: sleep_tracker.errors }, status: :unprocessable_entity
    end
  end

  # POST /sleep-trackers/awake
  def record_awake
    if sleep_tracker&.awake_at.nil?
      sleep_tracker.update(awake_at: Time.current, duration: Time.current - sleep_tracker.sleep_at)
      render json: { data: sleep_tracker }, status: :ok
    else
      render json: { error: "No sleep record found" }, status: :not_found
    end
  end

  def my_sleep_trackers
    limit = params[:limit] || 10
    offset = params[:offset] || 0
    sleep_trackers =  SleepTracker.where(user_id: current_user.id).order(sleep_at: :desc)
                                  .select(:id, :sleep_at, :awake_at, :duration)
                                  .limit(limit).offset(offset)
    render json: { data: sleep_trackers, meta: { limit: limit, offset: offset } }, status: :ok
  end

  # GET /sleep-trackers/followers
  def followers_sleep_trackers
    limit = params[:limit] || 10
    offset = params[:offset] || 0
    follower_ids = current_user.followers.map(&:follower_user_id)
    sleep_trackers = User.joins(:sleep_trackers).where("user_id IN (?)", follower_ids)
                         .order(sleep_at: :desc)
                         .select("sleep_trackers.id ,users.name, sleep_trackers.sleep_at, sleep_trackers.awake_at, sleep_trackers.duration")
                         .limit(limit).offset(offset)
    render json: { data: sleep_trackers, meta: { limit: limit, offset: offset } }, status: :ok
  end

  private

  def set_sleep_tracker
    @sleep_tracker ||= SleepTracker.where(user_id: current_user.id).order(sleep_at: :desc).first
  end
end
