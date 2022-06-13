require 'rails_helper'

RSpec.describe 'Searching for books by location' do
  context 'happy path tests' do
    before :each do
      books_response = File.read('spec/fixtures/books_response.json')
      stub_request(:get, "http://openlibrary.org/search.json?q=denver,co")
        .to_return(status: 200, body: books_response, headers: {})

      map_quest_params = {
        key: ENV['map_quest_key'],
        location: 'denver,co'
      }
      denver_data = File.read('spec/fixtures/map_quest_denver_response.json')
      stub_request(:get, "http://www.mapquestapi.com/geocoding/v1/address")
        .with(query: map_quest_params)
        .to_return(status: 200, body: denver_data, headers: {})

      open_weather_map_params = {
        lat: 39.738453,
        lon: -104.984853,
        appid: ENV['open_weather_map_key'], 
        units: 'imperial'
      }
      denver_forecast_response = File.read('spec/fixtures/denver_forecast_response.json')
      stub_request(:get, "https://api.openweathermap.org/data/2.5/onecall")
        .with(query: open_weather_map_params)
        .to_return(status: 200, body: denver_forecast_response, headers: {})

      get '/api/v1/book-search?location=denver,co&quantity=5'

      @full_response = JSON.parse(response.body, symbolize_names: true) 
    end

    it 'returns http status 200' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it 'has a data hash, with a nil ID and type set to books' do
      expect(@full_response).to have_key :data
      expect(@full_response[:data]).to be_a Hash

      expect(@full_response[:data]).to have_key :id
      expect(@full_response[:data][:id]).to be_nil

      expect(@full_response[:data]).to have_key :type
      expect(@full_response[:data][:type]).to eq 'books'
    end

    context 'attributes' do
      it 'has an attributes hash' do
        expect(@full_response[:data]).to have_key :attributes
        expect(@full_response[:data][:attributes]).to be_a Hash
        attributes = @full_response[:data][:attributes]

        expect(attributes).to have_key :total_books_found
        expect(attributes[:total_books_found]).to be_an Integer

        expect(attributes).to have_key :forecast
        expect(attributes[:forecast]).to be_a Hash

        expect(attributes).to have_key :destination
        expect(attributes[:destination]).to be_a String

        expect(attributes).to have_key :books
        expect(attributes[:books]).to be_an Array
        expect(attributes[:books]).to be_all Hash
        expect(attributes[:books].count).to eq 5
      end

      before { @attributes = @full_response[:data][:attributes] }

      it 'has forecast data' do
        forecast = @attributes[:forecast]

        expect(forecast).to have_key :summary
        expect(forecast[:summary]).to be_a String

        expect(forecast).to have_key :temperature
        expect(forecast[:temperature]).to be_a String
      end

      it 'has an array of books data' do
        books = @attributes[:books]

        books.each do |book|
          expect(book).to have_key :isbn
          expect(book[:isbn]).to be_an Array
          expect(book[:isbn]).to be_all String
          expect(book[:isbn].count).to eq 2

          expect(book).to have_key :title
          expect(book[:title]).to be_a String

          expect(book).to have_key :publisher
          expect(book[:publisher]).to be_an Array
          expect(book[:publisher]).to be_all String
        end
      end
    end
  end

  context 'sad path/edge case tests' do
    it 'quantity must be a whole number' do
      get '/api/v1/book-search?location=denver,co&quantity=not_a_number'
      full_response = JSON.parse(response.body, symbolize_names: true) 

      expect(response).to_not be_successful
      expect(response).to have_http_status 400

      expect(full_response).to have_key :error
      expect(full_response[:error]).to eq 'quantity must be a whole number'
    end

    it 'quantity can not be a float' do
      get '/api/v1/book-search?location=denver,co&quantity=5.5'
      full_response = JSON.parse(response.body, symbolize_names: true) 

      expect(response).to_not be_successful
      expect(response).to have_http_status 400

      expect(full_response).to have_key :error
      expect(full_response[:error]).to eq 'quantity must be a whole number'
    end
  end
end
