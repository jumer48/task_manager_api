class User < ApplicationRecord
  # Devise authentication (bcrypt is used internally)
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable, jwt_revocation_strategy: Devise::JWT::RevocationStrategies::Null

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 6 }, if: -> { new_record? || !password.nil? }

  before_validation :normalize_email
  before_create :set_jti

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
    self.email = nil if email.blank?
  end

  def set_jti
    self.jti ||= SecureRandom.uuid
  end
end
