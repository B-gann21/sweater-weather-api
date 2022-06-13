require 'rails_helper'

RSpec.describe ForecastFacade do
  context 'class methods' do
    it '.city_coordinates returns a hash of latitude and longitude' do
      denver_data = File.read('spec/fixtures/map_quest_denver_response.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=denver,co")
        .to_return(status: 200, body: denver_data, headers: {})

      coordinates = ForecastFacade.city_coordinates('denver,co')

      expect(coordinates).to be_a Hash
      expect(coordinates).to have_key :lat
      expect(coordinates[:lat]).to eq 39.738453

      expect(coordinates).to have_key :lng
      expect(coordinates[:lng]).to eq -104.984853
    end

    it '.hourly_forecast returns an array of HourlyForecast objects' do
      forecasts = ForecastFacade.hourly_forecast('denver,co')

      expect(forecasts).to be_an Array
      expect(forecasts).to be_all HourlyForecast
    end

    it '.current_forecast returns a CurrentForecast object' do
      forecast = ForecastFacade.current_forecast('denver,co')

      expect(forecast).to be_a CurrentForecast
    end

    it '.daily_forecast returns an array of DailyForecast objects'
    it '.full_forecast returns a ForecastRepo object'
  end
end
