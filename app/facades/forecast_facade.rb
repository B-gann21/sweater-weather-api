class ForecastFacade
  def self.hourly_forecast(city)
    raw_forecast_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

    raw_forecast_data[:hourly].map { |hourly_data| HourlyForecast.new(hourly_data) }
  end

  def self.current_forecast(city)
    raw_forecast_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

    CurrentForecast.new(raw_forecast_data[:current])
  end

  def self.city_coordinates(city)
    MapQuestService.get_city_info(city)[:results][0][:locations][0][:latLng]
  end
end
