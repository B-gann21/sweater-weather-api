require 'rails_helper'

RSpec.describe RoadTripFacade do
  context 'instance methods' do
    it '.build_road_trip returns a RoadTrip object' do
      directions_query = {
        key: ENV['map_quest_key'],
        from: 'Denver,CO',
        to: 'Pueblo,CO'
      }
      pueblo_to_denver_response = File.read('spec/fixtures/pueblo_to_denver_response.json')
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route")
        .with(query: directions_query)
        .to_return(status:200, body: pueblo_to_denver_response, headers:{})

      geocoding_pueblo_query = {
        key: ENV['map_quest_key'],
        location: 'Pueblo,CO'
      }
      pueblo_info_response = File.read('spec/fixtures/pueblo_info_response.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address")
        .with(query: geocoding_pueblo_query)
        .to_return(status: 200, body: pueblo_info_response, headers: {})

      geocoding_denver_query = {
        key: ENV['map_quest_key'],
        location: 'Denver,CO'
      }
      denver_info_response = File.read('spec/fixtures/map_quest_denver_response.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address")
        .with(query: geocoding_denver_query)
        .to_return(status: 200, body: denver_info_response, headers: {})
      
      pueblo_weather_query = {
        lat: 38.265425,
        lon: -104.610415,
        units: 'imperial',
        appid: ENV['open_weather_map_key']
      }
      pueblo_weather_response = File.read('spec/fixtures/pueblo_weather_response.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall")
        .with(query: pueblo_weather_query)
        .to_return(status: 200, body: pueblo_weather_response, headers: {})

      result = RoadTripFacade.build_road_trip('Denver,CO', 'Pueblo,CO')

      expect(result).to be_a RoadTrip
    end
  end
end
