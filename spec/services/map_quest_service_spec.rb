require 'rails_helper'

RSpec.describe MapQuestService do
  context 'class methods' do
    it '.get_city_info returns a hash of a given city' do
      denver_data = File.read('spec/fixtures/map_quest_denver_response.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address?key=#{ENV['map_quest_key']}&location=denver,co")
        .to_return(status: 200, body: denver_data, headers: {})

      result = MapQuestService.get_city_info('denver,co')
      expect(result).to be_a Hash

      expect(result).to have_key :info
      expect(result[:info]).to be_a Hash

      expect(result).to have_key :results
      expect(result[:results]).to be_a Array

      city_data = result[:results][0][:locations][0]

      expect(city_data).to have_key :latLng
      expect(city_data[:latLng]).to be_a Hash

      expect(city_data[:latLng]).to have_key :lat
      expect(city_data[:latLng][:lat]).to be_a Float

      expect(city_data[:latLng]).to have_key :lng
      expect(city_data[:latLng][:lng]).to be_a Float
    end

    it '.get_directions returns a hash of directions' do
      result = MapQuestService.get_directions('Denver,CO', 'Pueblo,CO')
      expect(result).to be_a Hash

      expect(result).to have_key :route
      expect(result[:route]).to be_a Hash

      expect(result[:route]).to have_key :formattedTime
      expect(result[:route][:formatted_time]).to be_a String

      expect(result[:route]).to have_key :legs
      expect(result[:route][:legs]).to be_an Array
      expect(result[:route][:legs]).to be_all Hash
    end
  end
end
