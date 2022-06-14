class Api::V1::UsersController < ApplicationController
  before_action :validate_content_type, :parse_json

  def create
    user = User.build_from_request(request.body.read)

    if user.valid_and_confirmed_password?
      user.save
      render json: Api::V1::UserSerializer.user_show(user), status: 201

    else
      render json: Api::V1::UserErrorSerializer.bad_create_request(user), status: 400
    end
  end
end
