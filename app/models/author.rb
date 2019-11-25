class Author < ApplicationRecord
  has_secure_password
  EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, uniqueness: {case_sensetive: false}, format: {with: EMAIL_REGEXP}
  has_many :posts
  has_many :comments
end
