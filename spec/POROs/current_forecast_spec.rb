require 'rails_helper'

RSpec.describe CurrentForecast do
  context 'initialization' do
    before :each do
      @current_weather_response = {
        dt: 1655089221,
        sunrise: 1655033490,
        sunset: 1655087299,
        temp: 77.81,
        feels_like: 76.84,
        pressure: 1000,
        humidity: 33,
        dew_point: 46.44,
        uvi: 0,
        clouds: 92,
        visibility: 10000,
        wind_speed: 6.85,
        wind_deg: 217,
        wind_gust: 11.43,
        weather: [
          {
            id: 804,
            main: "Clouds",
            description: "overcast clouds",
            icon: "04n"
          }
        ]
      }
    end

    it 'can be initialized with a hash' do
      forecast = CurrentForecast.new(@current_weather_response)
      expect(forecast).to be_a Forecast
    end

    it 'has readable attributes' do
      forecast = CurrentForecast.new(@current_weather_response)

      expect(forecast.datetime).to be_an_instance_of Time
      expect(forecast.sunrise).to be_an_instance_of Time
      expect(forecast.sunset).to be_an_instance_of Time
      expect(forecast.temperature).to be_a Float
      expect(forecast.feels_like).to be_a Float
      expect(forecast.humidity).to be_an Integer
      expect(forecast.uvi).to be_an Integer
      expect(forecast.visibility).to be_an(Integer).or be_a(Float)
      expect(forecast.conditions).to be_a String
      expect(forecast.icon).to be_a String

      expect(forecast).to_not respond_to :pressure
      expect(forecast).to_not respond_to :dew_point
      expect(forecast).to_not respond_to :clouds
      expect(forecast).to_not respond_to :wind_speed
      expect(forecast).to_not respond_to :wind_deg
      expect(forecast).to_not respond_to :wind_gust
      expect(forecast).to_not respond_to :id
      expect(forecast).to_not respond_to :main
    end
  end
end
