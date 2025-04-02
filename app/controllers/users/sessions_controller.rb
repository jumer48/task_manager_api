# app/controllers/users/sessions_controller.rb
class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    render json: {
      message: "Logged in successfully",
      user: resource.as_json(except: :jti)
    }, status: :ok
  end

  def respond_to_on_destroy
    if current_user
      current_user.revoke_jwt(request.headers["Authorization"]&.split&.last)
      render json: {
        message: "Logged out successfully. Please login again to continue."
      }, status: :ok
    else
      render json: {
        error: "No active session found"
      }, status: :unauthorized
    end
  end
end
