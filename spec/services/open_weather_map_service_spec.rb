require 'rails_helper'

RSpec.describe OpenWeatherMapService do
  context 'class methods' do
    context '.get_forecast returns a hash of weather data' do
      before :each do
        query_params = {
          lat: 39.738453,
          lon: -104.984853,
          appid: ENV['open_weather_map_key'], 
          units: 'imperial'
        }
        denver_forecast_response = File.read('spec/fixtures/denver_forecast_response.json')

        stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall")
          .with(query: query_params)
          .to_return(status: 200, body: denver_forecast_response, headers: {})

        coordinates = { lat: 39.738453, lng: -104.984853 } 
        @result = OpenWeatherMapService.get_forecast(coordinates)
      end

      it 'has current weather' do
        expect(@result).to be_a Hash
        expect(@result).to have_key :current
        expect(@result[:current]).to be_a Hash

        expect(@result[:current]).to have_key :dt
        expect(@result[:current][:dt]).to be_an Integer

        expect(@result[:current]).to have_key :sunrise
        expect(@result[:current][:sunrise]).to be_an Integer

        expect(@result[:current]).to have_key :temp
        expect(@result[:current][:temp]).to be_a Float

        expect(@result[:current]).to have_key :feels_like
        expect(@result[:current][:feels_like]).to be_a Float

        expect(@result[:current]).to have_key :humidity
        expect(@result[:current][:humidity]).to be_an Integer

        expect(@result[:current]).to have_key :uvi
        expect(@result[:current][:uvi]).to be_an Integer

        expect(@result[:current]).to have_key :visibility
        expect(@result[:current][:visibility]).to be_an Integer

        expect(@result[:current]).to have_key :weather
        expect(@result[:current][:weather]).to be_an Array

        expect(@result[:current][:weather][0]).to be_a Hash
        expect(@result[:current][:weather][0]).to have_key :description
        expect(@result[:current][:weather][0][:description]).to be_a String

        expect(@result[:current][:weather][0]).to have_key :icon
        expect(@result[:current][:weather][0][:icon]).to be_a String
      end

      it 'has daily weather' do
        expect(@result).to have_key :daily
        expect(@result[:daily]).to be_an Array

        @result[:daily].each do |forecast|
          expect(forecast).to have_key :dt
          expect(forecast[:dt]).to be_an Integer

          expect(forecast).to have_key :sunset
          expect(forecast[:sunrise]).to be_an Integer

          expect(forecast).to have_key :sunset
          expect(forecast[:sunset]).to be_an Integer

          expect(forecast).to have_key :moonrise
          expect(forecast[:moonrise]).to be_an Integer

          expect(forecast).to have_key :moonset
          expect(forecast[:moonset]).to be_an Integer

          expect(forecast).to have_key :moon_phase
          expect(forecast[:moon_phase]).to be_a Float

          expect(forecast).to have_key :temp
          expect(forecast[:temp]).to be_a Hash

          expect(forecast[:temp]).to have_key :day
          expect(forecast[:temp][:day]).to be_a Float

          expect(forecast[:temp]).to have_key :min
          expect(forecast[:temp][:min]).to be_a Float

          expect(forecast[:temp]).to have_key :max
          expect(forecast[:temp][:max]).to be_a Float

          expect(forecast[:temp]).to have_key :night
          expect(forecast[:temp][:night]).to be_a Float

          expect(forecast[:temp]).to have_key :eve
          expect(forecast[:temp][:eve]).to be_a Float

          expect(forecast[:temp]).to have_key :morn
          expect(forecast[:temp][:morn]).to be_a Float

          expect(forecast).to have_key :feels_like
          expect(forecast[:feels_like]).to be_a Hash

          expect(forecast[:feels_like]).to have_key :day
          expect(forecast[:feels_like][:day]).to be_a(Float).or be_a(Integer)

          expect(forecast[:feels_like]).to have_key :night
          expect(forecast[:feels_like][:night]).to be_a(Float).or be_a(Integer)
          
          expect(forecast[:feels_like]).to have_key :eve
          expect(forecast[:feels_like][:eve]).to be_a(Float).or be_a(Integer)

          expect(forecast[:feels_like]).to have_key :morn
          expect(forecast[:feels_like][:morn]).to be_a(Float).or be_a(Integer)

          expect(forecast).to have_key :pressure
          expect(forecast[:pressure]).to be_an Integer
          
          expect(forecast).to have_key :humidity
          expect(forecast[:humidity]).to be_an Integer
          
          expect(forecast).to have_key :dew_point
          expect(forecast[:dew_point]).to be_a Float
          
          expect(forecast).to have_key :wind_speed
          expect(forecast[:wind_speed]).to be_a Float
          
          expect(forecast).to have_key :wind_deg
          expect(forecast[:wind_deg]).to be_an Integer
          
          expect(forecast).to have_key :wind_gust
          expect(forecast[:wind_gust]).to be_a Float
          
          expect(forecast).to have_key :weather
          expect(forecast[:weather]).to be_an Array
          expect(forecast[:weather]).to be_all Hash

          expect(forecast[:weather][0]).to have_key :id
          expect(forecast[:weather][0][:id]).to be_an Integer

          expect(forecast[:weather][0]).to have_key :main
          expect(forecast[:weather][0][:main]).to be_a String

          expect(forecast[:weather][0]).to have_key :description
          expect(forecast[:weather][0][:description]).to be_a String

          expect(forecast[:weather][0]).to have_key :icon
          expect(forecast[:weather][0][:icon]).to be_a String
        end
      end

      it 'has hourly weather' do
        expect(@result).to have_key :hourly
        expect(@result[:hourly]).to be_an Array

        @result[:hourly].each do |forecast|
          expect(forecast).to have_key :dt
          expect(forecast[:dt]).to be_an Integer

          expect(forecast).to have_key :temp
          expect(forecast[:temp]).to be_a Float

          expect(forecast).to have_key :feels_like
          expect(forecast[:feels_like]).to be_a Float

          expect(forecast).to have_key :weather
          expect(forecast[:weather]).to be_an Array

          expect(forecast[:weather][0]).to be_a Hash
          expect(forecast[:weather][0]).to have_key :description
          expect(forecast[:weather][0][:description]).to be_a String

          expect(forecast[:weather][0]).to have_key :icon
          expect(forecast[:weather][0][:icon]).to be_a String
        end
      end
    end
  end
end
