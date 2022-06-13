require 'rails_helper'

RSpec.describe ForecastFacade do
  context 'class methods' do
    it '.hourly_forecast returns an array of Forecast objects' do
      forecasts = ForecastFacade.hourly_forecast('denver,co')

      expect(forecasts).to be_an Array
      expect(forecasts).to be_all Forecast
    end

    it '.current_forecast returns a CurrentForecast object' do
      forecast = ForecastFacade.current_forecast('denver,co')

      expect(forecast).to be_a CurrentForecast
    end

    it '.daily_forecast returns an array of DailyForecast objects'
    it '.full_forecast returns a ForecastRepo object'
  end
end
