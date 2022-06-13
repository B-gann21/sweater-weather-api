require 'rails_helper'

RSpec.describe ForecastFacade do
  context 'class methods' do
    it '.current_forecast returns a CurrentForecast object' do
      forecast = ForecastFacade.current_forecast('Denver')

      expect(forecast).to be_a CurrentForecast
    end

    it '.daily_forecast returns an array of DailyForecast objects'
    it '.hourly_forecast returns an array of HourlyForecast objects'
    it '.full_forecast returns a ForecastRepo object'
  end
end
