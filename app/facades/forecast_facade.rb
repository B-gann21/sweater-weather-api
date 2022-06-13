class ForecastFacade
  def self.hourly_forecast(city)
    raw_forecast_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

    raw_forecast_data[:hourly].map { |hourly_data| Forecast.new(hourly_data) }
  end

  def self.city_coordinates(city)
    MapQuestService.get_city_info(city)[:results][0][:locations][0][:latLng]
  end
end
