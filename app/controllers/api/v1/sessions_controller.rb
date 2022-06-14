class Api::V1::SessionsController < ApplicationController
  before_action :validate_content_type, :parse_json

  def create
    user = User.find_by(email: @body[:email])

    if user && user.authenticate(@body[:password])
      render json: Api::V1::UserSerializer.user_show(user)
    else
      bad_credentials
    end
  end
end
