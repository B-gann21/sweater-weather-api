require 'rails_helper'

RSpec.describe RoadTrip do
  before :each do
    @road_trip_data = {
      start_city: 'Denver,CO',
      end_city: 'Pueblo,CO',
      travel_time: '01:45:38',
      weather: build(:hourly_forecast)
    }
  end

  it 'can be initialized with a hash' do
    trip = RoadTrip.new(@road_trip_data)

    expect(trip).to be_a RoadTrip
  end

  it 'has readable attributes' do
    trip = RoadTrip.new(@road_trip_data)

    expect(trip.start_city).to eq 'Denver,CO'
    expect(trip.end_city).to eq 'Pueblo,CO'
    expect(trip.travel_time).to eq '01:45:38'
    expect(trip.weather_at_eta).to be_a HourlyForecast
  end
end
