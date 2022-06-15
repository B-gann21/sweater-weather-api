class Api::V1::UsersController < ApplicationController
  include UserHelper
  before_action :validate_content_type, :parse_json

  def create
    user = User.build_from_request(request.body.read)
    validate_creation(user)
  end
end
