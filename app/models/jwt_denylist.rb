# app/models/jwt_denylist.rb
class JwtDenylist < ApplicationRecord
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = "jwt_denylist"

  def self.jwt_revoked?(payload, _user)
    exists?(jti: payload["jti"])
  end

  def self.revoke_jwt(payload, _user)
    create!(jti: payload["jti"], exp: Time.at(payload["exp"].to_i))
  end
end
