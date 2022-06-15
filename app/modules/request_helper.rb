module RequestHelper
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

  def parse_json
    @body = JSON.parse(request.body.read, symbolize_names: true)
  end
end
