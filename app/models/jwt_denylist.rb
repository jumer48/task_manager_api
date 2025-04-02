# app/models/jwt_denylist.rb
class JwtDenylist < ApplicationRecord
    include Devise::JWT::RevocationStrategies::Denylist
    
    self.table_name = 'jwt_denylist'
  
    def self.jwt_revoked?(payload, user)
      exists?(jti: payload['jti'])
    end
  
    def self.revoke_jwt(payload, user)
      create!(jti: payload['jti'], exp: Time.at(payload['exp']))
    end
  end