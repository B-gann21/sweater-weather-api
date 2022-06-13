require 'rails_helper'

RSpec.describe BookSearchFacade do
  context 'class methods' do
    it '.weather_and_books returns weather and book POROs based on a given city' do
      result = BookSearchFacade.find_weather_and_books('denver,co', 5)

      expect(result).to be_a Hash
      expect(result).to have_key :weather
      expect(result[:weather]).to be_an_instance_of Weather

      expect(result).to have_key :books
      expect(result[:books]).to be_an Array
      expect(result[:books]).to be_all Book
      expect(result[:books].count).to eq 5

      expect(result).to have_key :weather
      expect(result[:weather]).to be_a Weather
    end
  end
end
