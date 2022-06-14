class Api::V1::UserErrorSerializer
  def self.bad_create_request(user)
    if user.email.empty? || User.find_by(email: user.email)
      { error: 'invalid email' }
    elsif user.password != user.password_confirmation
      { error: 'passwords must match' }
    end
  end
end
