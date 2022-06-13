class ForecastRepo
  attr_reader :current_forecast, :hourly_forecasts, :daily_forecasts

  def initialize(data)
    @current_forecast = data[:current_weather]
    @hourly_forecasts = data[:hourly_forecasts]
    @daily_forecasts = data[:daily_forecasts]
  end
end
