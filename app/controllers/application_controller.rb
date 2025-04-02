# app/controllers/application_controller.rb
class ApplicationController < ActionController::API
  # Load the error handler
  require "./app/lib/jwt_error_handler"
  include JwtErrorHandler

  include Devise::Controllers::Helpers
  before_action :authenticate_user!
  respond_to :json

  private

  def respond_to_on_destroy
    if current_user
      render json: {
        message: "You have been successfully logged out."
      }, status: :ok
    else
      render json: {
        error: "No active session found"
      }, status: :unauthorized
    end
  end
end
