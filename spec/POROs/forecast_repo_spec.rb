require 'rails_helper'

RSpec.describe ForecastRepo do
  before :each do
    allow_any_instance_of(CurrentForecast)
      .to receive(:initialize)
      .with({})
      .and_return(an_instance_of(CurrentForecast))

    allow_any_instance_of(HourlyForecast)
      .to receive(:initialize)
      .with({})
      .and_return(an_instance_of(HourlyForecast))

    allow_any_instance_of(DailyForecast)
      .to receive(:initialize)
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

    expect(repo.current_forecast).to be_a CurrentForecast

    expect(repo.hourly_forecasts).to be_an Array
    expect(repo.hourly_forecasts).to be_all HourlyForecast

    expect(repo.daily_forecasts).to be_an Array
    expect(repo.daily_forecasts).to be_all DailyForecast
  end
end
