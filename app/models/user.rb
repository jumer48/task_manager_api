class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null


  has_secure_password

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }


  validates :password,
    length: { minimum: 6 },
    if: -> { new_record? || !password.nil? }


  before_validation :normalize_email

  private
  def normalize_email
    self.email = email.to_s.strip.downcase
    self.email = nil if email.blank?
  end
end
