class Api::V1::UserSerializer
  def self.user_show(user)
    {
      data: {
        id: user.id.to_s,
        type: 'users',
        attributes: {
          email: user.email,
          api_key: user.api_key
        }
      }
    }
  end
end
