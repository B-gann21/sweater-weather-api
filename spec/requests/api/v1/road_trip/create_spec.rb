require 'rails_helper'

RSpec.describe 'The Roadtrip endpoint' do
  context 'happy path tests' do
    before :each do
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

      User.create!(email: '123@gmail.com',
                   password: '12345',
                   password_confirmation: '12345',
                   api_key: '54321')

      body = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: '54321'
      }

      headers = { 'CONTENT_TYPE': 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      @full_response = JSON.parse(response.body, symbolize_names: true) 
    end

    it 'returns status code 200' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it 'has a data hash with a nil ID and type is set to roadtrip' do
      expect(@full_response).to have_key :data
      expect(@full_response[:data]).to be_a Hash

      expect(@full_response[:data]).to have_key :id
      expect(@full_response[:data][:id]).to be_nil

      expect(@full_response[:data]).to have_key :type
      expect(@full_response[:data][:type]).to eq 'roadtrip'
    end

    it 'has attributes in a hash' do
      expect(@full_response[:data]).to have_key :attributes
      expect(@full_response[:data][:attributes]).to be_a Hash
      rt_attributes = @full_response[:data][:attributes]

      expect(rt_attributes).to have_key :start_city
      expect(rt_attributes[:start_city]).to be_a String

      expect(rt_attributes).to have_key :end_city
      expect(rt_attributes[:end_city]).to be_a String

      expect(rt_attributes).to have_key :travel_time
      expect(rt_attributes[:travel_time]).to be_a String

      expect(rt_attributes).to have_key :weather_at_eta
      expect(rt_attributes[:weather_at_eta]).to be_a Hash
      weather = rt_attributes[:weather_at_eta]

      expect(weather).to have_key :temperature
      expect(weather[:temperature]).to be_a Float

      expect(weather).to have_key :conditions
      expect(weather[:conditions]).to be_a String
    end

    it 'impossible travel time results in empty weather response' do
      directions_query = {
        key: ENV['map_quest_key'],
        from: 'Denver,CO',
        to: 'London,UK'
      }
      denver_to_london_response = File.read('spec/fixtures/denver_to_london_response.json')
      stub_request(:get, "http://www.mapquestapi.com/directions/v2/route")
        .with(query: directions_query)
        .to_return(status:200, body: denver_to_london_response, headers:{})

      body = {
        origin: 'Denver,CO',
        destination: 'London,UK',
        api_key: '54321'
      }

      headers = { 'CONTENT_TYPE': 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)
      
      expect(response).to be_successful
      expect(response).to have_http_status 200
      full_response = JSON.parse(response.body, symbolize_names: true) 

      expect(full_response).to have_key :data
      expect(full_response[:data]).to be_a Hash

      expect(full_response[:data]).to have_key :id
      expect(full_response[:data][:id]).to be_nil
      expect(full_response[:data]).to have_key :type
      expect(full_response[:data][:type]).to eq 'roadtrip'

      expect(full_response[:data]).to have_key :attributes
      expect(full_response[:data][:attributes]).to be_a Hash
      attributes = full_response[:data][:attributes]

      expect(attributes).to have_key :start_city
      expect(attributes[:start_city]).to eq('Denver,CO')

      expect(attributes).to have_key :end_city
      expect(attributes[:end_city]).to eq('London,UK')

      expect(attributes).to have_key :travel_time
      expect(attributes[:travel_time]).to eq 'impossible'

      expect(attributes).to have_key :weather_at_eta
      expect(attributes[:weather_at_eta]).to be_a Hash
      expect(attributes[:weather_at_eta]).to be_empty
    end
  end

  context 'sad path tests' do
    it 'wrong api key sends an error' do
      User.create!(email: '123@gmail.com',
                   password: '12345',
                   password_confirmation: '12345',
                   api_key: '54321')

      body = {
        origin: 'Denver,CO',
        destination: 'Pueblo,CO',
        api_key: '12345'
      }

      headers = { 'CONTENT_TYPE': 'application/json' }

      post '/api/v1/road_trip', headers: headers, params: JSON.generate(body)

      expect(response).to_not be_successful
      expect(response).to have_http_status 401

      full_response = JSON.parse(response.body, symbolize_names: true) 
      expect(full_response).to have_key :error
      expect(full_response[:error]).to eq 'bad credentials'
    end
  end
end
