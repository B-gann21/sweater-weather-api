module ValidationHelper
  def validate_content_type
    if request.headers['CONTENT_TYPE'] != 'application/json'
      render json: { error: 'invalid content type' }, status: 400
    end
  end

  def check_params
    if !(/\A\d+\z/).match? params[:quantity]
      render json: { error: 'quantity must be a whole number' }, status: 400
    end
  end

  def validate_api_key
    if !User.valid_key?(@body[:api_key])
      bad_credentials
    end
  end

  def bad_credentials
    render json: { error: 'bad credentials' }, status: 401
  end
end
