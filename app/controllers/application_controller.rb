class ApplicationController < ActionController::API
    before_action :authenticate_user!

    def protected
        render json: { message: "Access granted!" }
      end
end
