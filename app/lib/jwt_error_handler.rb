# app/lib/jwt_error_handler.rb
module JwtErrorHandler
    def self.included(base)
      base.rescue_from JWT::DecodeError, with: :handle_jwt_error
      base.rescue_from JWT::ExpiredSignature, with: :handle_expired_token
      base.rescue_from JWT::VerificationError, with: :handle_jwt_error
    end
  
    private
  
    def handle_expired_token
      render json: { 
        error: "Your session has expired. Please login again." 
      }, status: :unauthorized
    end
  
    def handle_jwt_error
      if token_revoked?
        render_revoked_error
      else
        render_invalid_token_error
      end
    end
  
    def token_revoked?
      auth_header = request.headers['Authorization']
      return false unless auth_header
      
      token = auth_header.split.last
      payload = decode_token(token)
      payload && JwtDenylist.exists?(jti: payload['jti'])
    rescue JWT::DecodeError
      false
    end
  
    def decode_token(token)
      JWT.decode(
        token, 
        Rails.application.credentials.devise_jwt_secret_key!
      ).first
    end
  
    def render_revoked_error
      render json: { 
        error: "Your session was terminated. Please login again." 
      }, status: :unauthorized
    end
  
    def render_invalid_token_error
      render json: { 
        error: "Invalid authentication token. Please login again." 
      }, status: :unauthorized
    end
  end