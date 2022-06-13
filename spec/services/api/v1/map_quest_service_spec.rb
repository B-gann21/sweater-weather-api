require 'rails_helper'

RSpec.describe MapQuestService do
  context 'class methods' do
    it '.get_city_info returns a hash of a given city' do
      result = MapQuestService.get_city_info('denver,co')
      expect(result).to be_a Hash

      expect(result).to have_key :info
      expect(result[:info]).to be_a Hash

      expect(result).to have_key :results
      expect(result[:results]).to be_a Array

      city_data = result[:results][0][:location][0]

      expect(city_data).to have_key :latLng
      expect(city_data[:latLng]).to be_a Hash

      expect(city_data[:latLng]).to have_key :lat
      expect(city_data[:latLng][:lat]).to be_a Float

      expect(city_data[:latLng]).to have_key :lon
      expect(city_data[:latLng][:lon]).to be_a Float
    end
  end
end
