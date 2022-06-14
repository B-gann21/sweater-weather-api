class Api::V1::RoadTripController < Api::V1::UsersController
  before_action :validate_content_type, :parse_json, :validate_api_key

  def create
    trip = RoadTripFacade.build_road_trip(@body[:origin], @body[:destination])

    render json: Api::V1::RoadTripSerializer.trip_data(trip)
  end
end
