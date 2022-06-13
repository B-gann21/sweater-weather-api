require 'rails_helper'

RSpec.describe 'Searching for a forecast by city' do
  context 'happy path tests' do
    before :each do
      get '/api/v1/forecast?location=denver,co'

      @full_response = JSON.parse(response.body, symbolize_names: true) 
    end

    it 'returns status code 200' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it 'has a null ID, type is set to forecast, and an attributes hash' do
      expect(@full_response).to have_key :data
      expect(@full_response[:data]).to be_a Hash

      expect(@full_response[:data]).to have_key :id
      expect(@full_response[:data][:id]).to be_nil

      expect(@full_response[:data]).to have_key :type
      expect(@full_response[:data][:type]).to eq 'forecast'

      expect(@full_response[:data]).to have_key :attributes
      expect(@full_response[:data][:attributes]).to be_a Hash
    end

    context 'current weather' do
      it 'has current weather hash' do
        expect(@full_response[:data][:attributes]).to have_key :current_weather
        expect(@full_response[:data][:attributes][:current_weather]).to be_a Hash
      end

      before { @current_weather = @full_response[:data][:attributes][:current_weather] }

      it 'has the datetime in readable format (not unix)' do
        expect(@current_weather).to have_key :datetime
        expect(@current_weather[:datetime]).to be_a String

        actual_time = @current_weather[:datetime]
        parsed_time = Time.parse(actual_time)

        expect(parsed_time).to be_an_instance_of Time
        expect(Time.at(actual_time)).to raise_error(TypeError)
      end

      it 'has the sunrise time in readable format (not unix)' do
        expect(@current_weather).to have_key :sunrise
        expect(@current_weather[:sunrise]).to be_a String

        actual_sunrise = @current_weather[:sunrise]
        parsed_time = Time.parse(actual_sunrise)

        expect(parsed_time).to be_an_instance_of Time
        expect(Time.at(actual_time)).to raise_error(TypeError)
      end

      it 'has the sunset time in readable format (not unix)' do
        expect(@current_weather).to have_key :sunset
        expect(@current_weather[:sunset]).to be_a String

        actual_sunset = @current_weather[:sunset]
        parsed_time = Time.parse(actual_sunset)

        expect(parsed_time).to be_an_instance_of Time
        expect(Time.at(actual_time)).to raise_error(TypeError)
      end

      it 'has the current temp and feels like temp as floats' do
        expect(@current_weather).to have_key :temperature
        expect(@current_weather[:temperature]).to be_a Float

        expect(@current_weather).to have_key :feels_like
        expect(@current_weather[:feels_like]).to be_a Float
      end

      it 'has the humidity, uvi, and visibility as either integers or floats' do
        classes = [Float, Integer]

        expect(@current_weather).to have_key :humidity
        expect(classes).to include(@current_weather[:humidity])

        expect(@current_weather).to have_key :uvi
        expect(classes).to include(@current_weather[:uvi])

        expect(@current_weather).to have_key :visibility
        expect(classes).to include(@current_weather[:visibility])
      end

      it 'has conditions and icon strings' do
        expect(@current_weather).to have_key :conditions
        expect(@current_weather[:conditions]).to be_a String

        expect(@current_weather).to have_key :icon
        expect(@current_weather[:icon]).to be_a String
      end
    end

    context 'daily_weather' do
      it 'should have daily weather as a hash'
    end
  end
end

