require 'rails_helper'

RSpec.describe BookSearchFacade do
  context 'class methods' do
    it '.weather_and_books returns weather and book POROs based on a given city' do
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

      result = BookSearchFacade.find_weather_and_books('denver,co', 5)

      expect(result).to be_a Hash
      expect(result).to have_key :weather
      expect(result[:weather]).to be_an_instance_of Weather

      expect(result).to have_key :books
      expect(result[:books]).to be_an Array
      expect(result[:books]).to be_all Book
      expect(result[:books].count).to eq 5

      expect(result).to have_key :weather
      expect(result[:weather]).to be_a Weather

      expect(result).to have_key :total_books
      expect(result[:total_books]).to be_an Integer
    end
  end
end
