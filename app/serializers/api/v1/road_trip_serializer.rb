class Api::V1::RoadTripSerializer
  def self.trip_data(trip)
    {
      data: {
        id: nil,
        type: 'roadtrip',
        attributes: {
          start_city: trip.start_city,
          end_city: trip.end_city,
          travel_time: trip.travel_time,
          weather_at_eta: {
            temperature: trip.weather_at_eta.temperature,
            conditions: trip.weather_at_eta.conditions
          }
        }
      }
    }
  end
end
