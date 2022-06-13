require 'rails_helper'

RSpec.describe 'Endpoint to search for a background image' do
  context 'happy path tests' do
    before :each do
      unsplash_params = {
        client_id: ENV['unsplash_key'],
        query: 'denver,co'
      }
      unsplash_response = File.read('spec/fixtures/unsplash_response.json')
      stub_request(:get, "https://api.unsplash.com/search/photos")
        .with(query: unsplash_params)
        .to_return(status: 200, body: unsplash_response, headers: {})

      get '/api/v1/backgrounds?location=denver,co'

      @full_response = JSON.parse(response.body, symbolize_names: true) 
    end

    it 'has http status of 200' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it 'returns a data hash with an ID of nil, and type is set to image' do
      expect(@full_response).to have_key :data
      expect(@full_response[:data]).to be_a Hash
      
      expect(@full_response[:data]).to have_key :id
      expect(@full_response[:data][:id]).to be_nil

      expect(@full_response[:data]).to have_key :type
      expect(@full_response[:data][:type]).to eq 'image'
    end

    context 'attributes hash' do
      it 'has an attributes hash' do
        expect(@full_response[:data]).to have_key :attributes
        expect(@full_response[:data][:attributes]).to be_a Hash
      end

      before { @attributes = @full_response[:data][:attributes] }

      it 'has image data' do
        expect(@attributes).to have_key :image
        expect(@attributes[:image]).to be_a Hash

        expect(@attributes[:image]).to have_key :location
        expect(@attributes[:image][:location]).to be_a String

        expect(@attributes[:image]).to have_key :image_url
        expect(@attributes[:image][:image_url]).to be_a String  
      end

      it 'has image credits' do
        expect(@attributes[:image]).to have_key :credit
        expect(@attributes[:image][:credit]).to be_a Hash
        credits = @attributes[:image][:credit]

        expect(credits).to have_key :source
        expect(credits[:source]).to be_a String
        
        expect(credits).to have_key :author
        expect(credits[:author]).to be_a String
      end
    end
  end
end
