class RoadTripFacade < ForecastFacade
  def self.build_road_trip(start_city, end_city)
    trip_hash = {}
    trip_hash[:start_city] = start_city
    trip_hash[:end_city] = end_city

    if time = check_travel_time(start_city, end_city)
      trip_hash[:travel_time] = time
      trip_hash[:weather] = weather_at_arrival(end_city, time.to_i - 1)
    else
      trip_hash[:travel_time] = 'impossible'
    end
    RoadTrip.new(trip_hash)
  end

  def self.weather_at_arrival(end_city, hour_index)
    hourly_forecast(end_city)[hour_index]
  end

  def self.check_travel_time(start_city, end_city)
    response = MapQuestService.get_directions(start_city, end_city)
    time = response[:route][:formattedTime]

    return time if time
  end
end
