require 'rails_helper'

RSpec.describe BookSearchFacade do
  context 'class methods' do
    it '.weather_and_books returns weather and book POROs based on a given city' do
      books_response = File.read('spec/fixtures/books_response.json')
      stub_request(:get, "http://openlibrary.org/search.json?q=denver,co")
        .to_return(status: 200, body: books_response, headers: {})

      denver_data = File.read('spec/fixtures/map_quest_denver_response.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address")
        .to_return(status: 200, body: denver_data, headers: {})

      denver_forecast_response = File.read('spec/fixtures/denver_forecast_response.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall")
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
    end
  end
end
