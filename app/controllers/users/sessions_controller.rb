class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      message: "Logged in successfully",
      user: resource.as_json(except: :jti),
      token: request.env["warden-jwt_auth.token"]
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      # Get the JTI from the token before revoking
      token = request.headers["Authorization"]&.split&.last
      payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first rescue nil

      if payload
        JwtDenylist.revoke_jwt(payload, current_user)
      end

      render json: {
        message: "Logged out successfully"
      }, status: :ok
    else
      render json: {
        error: "No active session found"
      }, status: :unauthorized
    end
  end
end
