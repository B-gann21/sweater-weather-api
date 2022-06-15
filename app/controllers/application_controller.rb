class ApplicationController < ActionController::API
  include ValidationHelper

  def parse_json
    @body = JSON.parse(request.body.read, symbolize_names: true)
  end
end
