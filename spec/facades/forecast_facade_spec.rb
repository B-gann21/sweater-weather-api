require 'rails_helper'

RSpec.describe ForecastFacade do
  context 'class methods' do
    before :each do
      books_response = File.read('spec/fixtures/books_response.json')
      stub_request(:get, "http://openlibrary.org/search.json?q=denver,co")
        .to_return(status: 200, body: books_response, headers: {})

      map_quest_params = {
        key: ENV['map_quest_key'],
        location: 'denver,co'
      }
      denver_data = File.read('spec/fixtures/map_quest_denver_response.json')

      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address")
        .with(query: map_quest_params)
        .to_return(status: 200, body: denver_data, headers: {})

      open_weather_map_params = {
        lat: 39.738453,
        lon: -104.984853,
        appid: ENV['open_weather_map_key'], 
        units: 'imperial'
      }
      denver_forecast_response = File.read('spec/fixtures/denver_forecast_response.json')

      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall")
        .with(query: open_weather_map_params)
        .to_return(status: 200, body: denver_forecast_response, headers: {})
    end

    it '.city_coordinates returns a hash of latitude and longitude' do
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

    it '.daily_forecast returns an array of DailyForecast objects' do
      forecasts = ForecastFacade.daily_forecasts('denver,co')

      expect(forecasts).to be_an Array
      expect(forecasts).to be_all DailyForecast
    end
    
    it '.full_forecast returns a ForecastRepo object' do
      forecast = ForecastFacade.full_forecast('denver,co')

      expect(forecast).to be_a ForecastRepo
    end
  end
end
