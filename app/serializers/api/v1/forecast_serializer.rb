class Api::V1::ForecastSerializer
  def self.forecast_index(forecast)
    {
      data: {
        id: nil,
        type: 'forecast',
        attributes: {
          current_weather: {
            datetime: forecast.current_forecast.datetime,
            sunrise: forecast.current_forecast.sunrise,
            sunset: forecast.current_forecast.sunset,
            temperature: forecast.current_forecast.temperature,
            feels_like: forecast.current_forecast.feels_like,
            humidity: forecast.current_forecast.humidity,
            uvi: forecast.current_forecast.uvi,
            visibility: forecast.current_forecast.visibility,
            conditions: forecast.current_forecast.conditions,
            icon: forecast.current_forecast.icon,
          },

          daily_weather: forecast.daily_forecasts.map do |forecast|
            {
              date: forecast.date,
              sunrise: forecast.sunrise,
              sunset: forecast.sunset,
              max_temp: forecast.max_temp,
              min_temp: forecast.min_temp,
              conditions: forecast.conditions,
              icon: forecast.icon,
            }
          end,

          hourly_weather: forecast.hourly_forecasts.map do |forecast|
            {
              time: forecast.datetime,
              temperature: forecast.temperature,
              conditions: forecast.conditions,
              icon: forecast.icon,
            }
          end
        }
      }
    }
  end
end
