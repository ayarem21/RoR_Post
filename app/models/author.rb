class Author < ApplicationRecord
  has_secure_password

  before_create :confirmation_token
  after_create :send_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validate :email_validation
  validates :password, presence: true, allow_nil: true
  validate :password_validation

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  def password_reset
    confirmation_token
    self.pass_time = Time.zone.now
    save!(:validate => false)
    UserMailer.pass_reset(self).deliver!
  end

  private

  def email_validation
    errors.add(:email, "You enter invalid email") unless email.include?('@')
  end

  def password_validation
    if password.present?
      if password.count('a-z') <= 0 || password.count('A-Z') <= 0 || password.count('0-9') <= 0
        errors.add(:password, 'must contain 1 small letter, 1 capital letter, 1 number and minimum 8 symbols')
      end
    end
  end

  def send_confirmation
    UserMailer.welcome_email(self).deliver!
  end

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
  end
end
