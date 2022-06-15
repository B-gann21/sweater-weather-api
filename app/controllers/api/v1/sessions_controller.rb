class Api::V1::SessionsController < ApplicationController
  before_action :validate_content_type, :parse_json

  def create
    user = User.find_by(email: @body[:email])
    validate_login(user)
  end
end
