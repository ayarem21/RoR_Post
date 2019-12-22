class Author < ApplicationRecord
  has_secure_password

  before_create :confirmation_token
  after_create :send_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validate :email_validation
  #validates :password, presence: true, length: { minimum: 8 }
  #disable validation, because active admin don't work

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


  def send_confirmation
    UserMailer.welcome_email(self).deliver!
  end

  def confirmation_token
    self.confirm_token = SecureRandom.urlsafe_base64.to_s if self.confirm_token.blank?
  end
end
