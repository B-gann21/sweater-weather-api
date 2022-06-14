class Api::V1::UsersController < ApplicationController
  before_action :validate_headers

  def create
    body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.new(body)

    if user.save
      render json: Api::V1::UserSerializer.user_show(user)
    else
      render json: Api::V1::UserErrorSerializer.bad_request(user)
    end
  end

  private

  def validate_headers
    if request.headers['CONTENT_TYPE'] != 'application/json'
      render json: { error: 'invalid content type' }
    end
  end
end
