require 'rails_helper'

RSpec.describe Weather do
  before :each do
    @weather_response = {
      dt: 1655138387,
      sunrise: 1655119887,
      sunset: 1655173725,
      temp: 88.92,
      feels_like: 85.05,
      pressure: 998,
      humidity: 15,
      dew_point: 35.33,
      uvi: 8.22,
      clouds: 0,
      visibility: 10000,
      wind_speed: 4,
      wind_deg: 167,
      wind_gust: 8.01,
      weather: [
        {
          id: 800,
          main: "Clear",
          description: "clear sky",
          icon: "01d"
        }
      ]
    }
  end

  it 'can be initialized with a hash' do
    result = Weather.new(@weather_response)

    expect(result).to be_an_instance_of Weather
  end

  it 'has readable attributes' do
    weather = Weather.new(@weather_response)

    expect(weather.summary).to eq 'clear sky'
    expect(weather.temperature).to eq '88 F'
  end
end
