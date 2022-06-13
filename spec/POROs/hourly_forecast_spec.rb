require 'rails_helper'

RSpec.describe HourlyForecast do
  before :each do
    @hourly_weather_response = {
      dt: 1655089200,
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
      ],
      pop: 0
    }
  end

  it 'can be initialized with a hash' do
    forecast = HourlyForecast.new(@hourly_weather_response)
    expect(forecast).to be_a HourlyForecast
  end

  it 'has readable attributes' do
    forecast = HourlyForecast.new(@hourly_weather_response)

    expect(forecast.datetime).to be_an_instance_of Time
    expect(forecast.temperature).to be_a Float
    expect(forecast.conditions).to be_a String
    expect(forecast.icon).to be_a String

    expect(forecast).to_not respond_to :feels_like
    expect(forecast).to_not respond_to :uvi
    expect(forecast).to_not respond_to :visibility
    expect(forecast).to_not respond_to :description
    expect(forecast).to_not respond_to :pop
    expect(forecast).to_not respond_to :pressure
    expect(forecast).to_not respond_to :humidity
    expect(forecast).to_not respond_to :dew_point
    expect(forecast).to_not respond_to :clouds
    expect(forecast).to_not respond_to :wind_speed
    expect(forecast).to_not respond_to :wind_deg
    expect(forecast).to_not respond_to :wind_gust
    expect(forecast).to_not respond_to :id
    expect(forecast).to_not respond_to :main
  end
end
