require 'rails_helper'

RSpec.describe BackgroundFacade do
  context 'class methods' do
    it '.find_background_image returns a Background object' do
      unsplash_params = {
        client_id: ENV['unsplash_key'],
        query: 'denver,co'
      }
      unsplash_response = File.read('spec/fixtures/unsplash_response.json')
      stub_request(:get, "https://api.unsplash.com/search/photos")
        .with(query: unsplash_params)
        .to_return(status: 200, body: unsplash_response, headers: {})

      result = BackgroundFacade.find_background_image('denver,co')

      expect(result).to be_a Background
    end
  end
end
