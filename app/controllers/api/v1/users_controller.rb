class Api::V1::UsersController < ApplicationController
  include UserHelper
  before_action :validate_content_type, :parse_json

  def create
    user = build_user_from_request
    validate_creation(user)
  end
end
