class ApplicationController < ActionController::API
  def parse_json
    @body = JSON.parse(request.body.read, symbolize_names: true)
  end

  def validate_content_type
    if request.headers['CONTENT_TYPE'] != 'application/json'
      render json: { error: 'invalid content type' }, status: 400
    end
  end

  def bad_credentials
    render json: { error: 'bad credentials' }, status: 401
  end
end
