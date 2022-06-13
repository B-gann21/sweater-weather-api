require 'rails_helper'

RSpec.describe DailyForecast do
  before :each do
    @daily_weather_response = {
      dt: 1655056800,
      sunrise: 1655033490,
      sunset: 1655087299,
      moonrise: 1655081220,
      moonset: 1655027520,
      moon_phase: 0.43,
      temp: {
        day: 91.47,
        min: 71.96,
        max: 92.91,
        night: 77.94,
        eve: 83.66,
        morn: 71.96
      },
      feels_like: {
        day: 87.3,
        night: 76.69,
        eve: 81.25,
        morn: 70.03
      },
      pressure: 1002,
      humidity: 15,
      dew_point: 37.92,
      wind_speed: 10.67,
      wind_deg: 229,
      wind_gust: 24.7,
      weather: [
        {
          id: 804,
          main: "Clouds",
          description: "overcast clouds",
          icon: "04d"
        }
      ],
      clouds: 94,
      pop: 0.08,
      uvi: 10.08
    }
  end

  it 'can be initialized with a hash' do
    forecast = DailyForecast.new(@daily_weather_response)

    expect(forecast).to be_a DailyForecast
  end

  it 'has readable attributes' do
    forecast = DailyForecast.new(@daily_weather_response)

    expect(forecast.date).to eq '06/12/22' 
    expect(forecast.sunrise).to be_a Time
    expect(forecast.sunset).to be_a Time
    expect(forecast.max_temp).to eq 92.91
    expect(forecast.min_temp).to eq 71.96
    expect(forecast.conditions).to eq 'overcast clouds'
    expect(forecast.icon).to eq '04d'

    expect(forecast).to_not respond_to :feels_like
    expect(forecast).to_not respond_to :uvi
    expect(forecast).to_not respond_to :visibility
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
