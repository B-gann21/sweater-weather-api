require 'rails_helper'

RSpec.describe UnsplashService do
  context 'class methods' do
    it '.search_for_background reurns a hash of image results' do
      unsplash_params = {
        client_id: ENV['unsplash_key'],
        query: 'denver,co'
      }
      unsplash_response = File.read('spec/fixtures/unsplash_response.json')
      stub_request(:get, "https://api.unsplash.com/search/photos")
        .with(query: unsplash_params)
        .to_return(status: 200, body: unsplash_response, headers: {})
      
      result = UnsplashService.search_for_background('denver,co')
      expect(result).to be_a Hash

      expect(result).to have_key :total
      expect(result[:total]).to be_an Integer

      expect(result).to have_key :results
      expect(result[:results]).to be_an Array
      expect(result[:results]).to be_all Hash

      first_match = result[:results][0]
      expect(first_match).to have_key :id
      expect(first_match[:id]).to be_a String

      expect(first_match).to have_key :urls
      expect(first_match[:urls]).to be_a Hash
      expect(first_match[:urls]).to have_key :full
      expect(first_match[:urls][:full]).to be_a String

      expect(first_match).to have_key :user
      expect(first_match[:user]).to be_a Hash

      expect(first_match[:user]).to have_key :name
      expect(first_match[:user][:name]).to be_a String
    end
  end
end
