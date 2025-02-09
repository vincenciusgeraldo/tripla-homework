class AuthController < ApplicationController
  # POST /auth/login
  def login
    if login_params[:user_id].present?
      token = ::JsonWebToken.encode(user_id: login_params[:user_id])
      render json: { token: token }, status: :ok
      return
    end
    render json: { error: "Invalid user_id" }, status: :unprocessable_entity
  end

  private

  def login_params
    params.permit(:user_id)
  end
end
