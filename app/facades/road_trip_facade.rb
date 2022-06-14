class RoadTripFacade < ForecastFacade
  def self.build_road_trip(start_city, end_city)
    travel_time = MapQuestService.get_directions(start_city, end_city)[:route][:formattedTime]
    
    trip_hash = {}
    trip_hash[:start_city] = start_city
    trip_hash[:end_city] = end_city
    trip_hash[:travel_time] = travel_time
    trip_hash[:weather] = weather_at_arrival(end_city, travel_time.to_i - 1)

    RoadTrip.new(trip_hash)
  end

  def self.weather_at_arrival(end_city, hour_index)
    hourly_forecast(end_city)[hour_index]
  end
end
