require 'rails_helper'

RSpec.describe ForecastRepo do
  before :each do
    allow(CurrentForecast)
      .to receive(:new)
      .with({})
      .and_return(an_instance_of(CurrentForecast))

    allow(HourlyForecast)
      .to receive(:new)
      .with({})
      .and_return(an_instance_of(HourlyForecast))

    allow(DailyForecast)
      .to receive(:new)
      .with({})
      .and_return(an_instance_of(DailyForecast))

    @forecast_repo_data = {
      current_forecast: CurrentForecast.new({}),
      hourly_forecasts: [],
      daily_forecasts: []
    }

    8.times do
      @forecast_repo_data[:hourly_forecasts] << HourlyForecast.new({})
      @forecast_repo_data[:daily_forecasts] << DailyForecast.new({})
    end
  end

  it 'is initalized with a hash of forecast objects' do
    repo = ForecastRepo.new(@forecast_repo_data)

    expect(repo).to be_a ForecastRepo
  end

  it 'has readable attributes' do
    repo = ForecastRepo.new(@forecast_repo_data)
    
    expect(repo.current_forecast.expected).to eq CurrentForecast

    expect(repo.hourly_forecasts).to be_an Array
    repo.hourly_forecasts.each do |forecast|
      expect(forecast.expected).to eq HourlyForecast
    end

    expect(repo.daily_forecasts).to be_an Array
    repo.daily_forecasts.each do |forecast|
      expect(forecast.expected).to eq DailyForecast
    end
  end
end
