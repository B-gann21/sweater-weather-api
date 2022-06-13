require 'rails_helper'

RSpec.describe OpenWeatherMapService do
  context 'class methods' do
    context '.get_forecast returns a hash of weather data' do
      it 'has current weather' do
        coordinates = { lat: 39.738453, lng: -104.984853 } 
        result = OpenWeatherMapService.get_forecast(coordinates)

        expect(result).to be_a Hash
        expect(result).to have_key :current
        expect(result[:current]).to be_a Hash

        expect(result[:current]).to have_key :dt
        expect(result[:current][:dt]).to be_an Integer

        expect(result[:current]).to have_key :sunrise
        expect(result[:current][:sunrise]).to be_an Integer

        expect(result[:current]).to have_key :temp
        expect(result[:current][:temp]).to be_a Float

        expect(result[:current]).to have_key :feels_like
        expect(result[:current][:feels_like]).to be_a Float

        expect(result[:current]).to have_key :humidity
        expect(result[:current][:humidity]).to be_an Integer

        expect(result[:current]).to have_key :uvi
        expect(result[:current][:uvi]).to be_an Integer

        expect(result[:current]).to have_key :visibility
        expect(result[:current][:visibility]).to be_an Integer

        expect(result[:current]).to have_key :weather
        expect(result[:current][:weather]).to be_an Array

        expect(result[:current][:weather][0]).to be_a Hash
        expect(result[:current][:weather][0]).to have_key :description
        expect(result[:current][:weather][0][:description]).to be_a String

        expect(result[:current][:weather][0]).to have_key :icon
        expect(result[:current][:weather][0][:icon]).to be_a String
      end

      it 'has daily weather'
      it 'hourly weather'
    end
  end
end
