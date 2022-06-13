class ForecastFacade
  def self.full_forecast(city)
    Rails.cache.fetch("#{city}-query") do
      raw_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

      forecast_hash = {}
      forecast_hash[:current_forecast] = current_forecast(city)
      forecast_hash[:hourly_forecasts] = hourly_forecast(city)
      forecast_hash[:daily_forecasts] = daily_forecasts(city)

      ForecastRepo.new(forecast_hash)
    end
  end

  def self.hourly_forecast(city)
    raw_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

    raw_data[:hourly].map { |hourly_data| HourlyForecast.new(hourly_data) }
  end

  def self.current_forecast(city)
    raw_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

    CurrentForecast.new(raw_data[:current])
  end

  def self.daily_forecasts(city)
    raw_data = OpenWeatherMapService.get_forecast(city_coordinates(city))

    raw_data[:daily].map { |daily_data| DailyForecast.new(daily_data) }
  end

  def self.city_coordinates(city)
    MapQuestService.get_city_info(city)[:results][0][:locations][0][:latLng]
  end
end
