class User < ApplicationRecord
  has_secure_password
  validates_presence_of :password_digest

  validates_presence_of :email
  validates_uniqueness_of :email

  validates_presence_of :api_key
end
