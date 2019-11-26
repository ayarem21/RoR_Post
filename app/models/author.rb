class Author < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validate :email_validation, :password_validation
  has_many :posts
  has_many :comments

  private
  def email_validation
  unless email.include?('@')
    errors.add(:email, "Youe enter invalid email")
  end
end

def password_validation
  unless  password.count("a-z") > 0 && password.count("A-Z") > 0 && password.count((0-9).to_s) > 0
    errors.add(:password, "must contain 1 small letter, 1 capital letter and number")
  end
end
end
