class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

         validates :email,
         presence: true,
         uniqueness: true,
         format: { with: URI::MailTo::EMAIL_REGEXP }

       before_validation :normalize_email

       private
       def normalize_email
         self.email = email.to_s.strip.downcase
         self.email = nil if email.blank?
       end
end
