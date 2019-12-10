class Author < ApplicationRecord
  has_secure_password
  before_create :confirmation_token
  after_create :send_confirmation
  validates :email, presence: true, uniqueness: true
  validate :email_validation
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(:validate => false)
  end

  private

  def email_validation
  unless email.include?('@')
    errors.add(:email, "Youe enter invalid email")
  end
end

  #def password_validation
  #  unless  password.count("a-z") > 0 && password.count("A-Z") > 0 && password.count((0-9).to_s) > 0
  #    errors.add(:password, "must contain 1 small letter, 1 capital letter and number")
  #  end
  #end

  def send_confirmation
    UserMailer.welcome_email(self).deliver!
  end

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
