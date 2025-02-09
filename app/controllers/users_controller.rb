class UsersController < ApplicationController
  before_action :authenticate, :set_user, :set_follower, :valid_user!

  # POST /users/:id/follow
  def follow
    if @follower
      render json: { error: "Already following" }, status: :conflict
      return
    end

    @user.followers.create!(user_id: @user.id, follower_user_id: current_user.id)
    render json: { message: "Followed" }, status: :ok
  end

  # POST /users/:id/unfollow
  def unfollow
    if @follower.nil?
      render json: { error: "Not following" }, status: :conflict
      return
    end
    @follower.destroy!
    render json: { message: "Unfollowed" }, status: :ok
  end

  private

  def valid_user!
    render json: { error: "Unauthorized" }, status: :unauthorized unless @user.id != current_user.id
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_follower
    @follower = @user.followers.find_by(follower_user_id: current_user.id)
  end
end
