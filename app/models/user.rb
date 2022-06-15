class User < ApplicationRecord
  has_secure_password
  validates_presence_of :password_digest

  validates_presence_of :email
  validates_uniqueness_of :email

  validates_presence_of :api_key

#  def self.build_from_request(body)
#    json = JSON.parse(body, symbolize_names: true) 
#    user = User.new(json)
#    user.api_key = SecureRandom.urlsafe_base64
#    user
#  end

  def self.valid_key?(key)
    find_by(api_key: key)
  end

  def valid_and_confirmed_password?
    valid? && (password == password_confirmation)
  end
end
