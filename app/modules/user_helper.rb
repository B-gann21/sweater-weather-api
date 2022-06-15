module UserHelper
  def build_user_from_request
    user = User.new(@body)
    user.api_key = SecureRandom.urlsafe_base64
    user
  end

  def validate_api_key
    if !User.valid_key?(@body[:api_key])
      bad_credentials
    end
  end

  def validate_creation(user)
    if user.valid_and_confirmed_password?
      user.save
      render json: Api::V1::UserSerializer.user_show(user), status: 201
    else
      render json: Api::V1::UserErrorSerializer.bad_create_request(user), status: 400
    end
  end

  def validate_login(user)
    if user && user.authenticate(@body[:password])
      render json: Api::V1::UserSerializer.user_show(user)
    else
      bad_credentials
    end
  end

  def bad_credentials
    render json: { error: 'bad credentials' }, status: 401
  end
end
