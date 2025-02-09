class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::ImplicitRender

  attr_reader :current_user

  before_action :set_default_response_format

  def authenticate
    header = request.headers["Authorization"]
    token = header.split(" ").last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
  end

  private

  def set_default_response_format
    request.format = :json
  end
end
