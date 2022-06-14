require 'rails_helper'

RSpec.describe 'Logging in a User' do
  context 'happy path tests' do
    before :each do
      User.create!(email: '123@gmail.com',
                   password: 'cool password',
                   api_key: '12345')

      body = {
        email: '123@gmail.com',
        password: 'cool password'
      }

      headers = { 'CONTENT_TYPE': 'application/json' }

      post '/api/v1/sessions', headers: headers, params: JSON.generate(body)

      @full_response = JSON.parse(response.body, symbolize_names: true) 
    end

    it 'has status code 200' do
      expect(response).to be_successful
      expect(response).to have_http_status 200
    end

    it 'has the user info in a hash' do
      expect(@full_response).to have_key :data
      expect(@full_response[:data]).to be_a Hash
      user_data = @full_response[:data]

      expect(user_data).to have_key :id
      expect(user_data[:id]).to be_a String

      expect(user_data).to have_key :type
      expect(user_data[:type]).to eq 'users'

      expect(user_data).to have_key :attributes
      expect(user_data[:attributes]).to be_a Hash
      attributes = user_data[:attributes]

      expect(attributes).to have_key :email
      expect(attributes[:email]).to eq '123@gmail.com'

      expect(attributes).to have_key :api_key
      expect(attributes[:api_key]).to eq '12345'

      expect(attributes).to_not have_key :password_digest
      expect(attributes).to_not have_key :password
      expect(user_data).to_not have_key :password_digest
      expect(user_data).to_not have_key :password
    end
  end

  context 'sad path tests' do
    context 'content type must be application/json' do
      it 'no headers returns an error' do
        body = {
          email: 'cool_email@gmail.com',
          password: 'cool password',
        }

        post '/api/v1/sessions', headers: {}, params: body

        expect(response).to_not be_successful
        expect(response).to have_http_status 400
        full_response = JSON.parse(response.body, symbolize_names: true) 

        expect(full_response).to have_key :error
        expect(full_response[:error]).to eq 'invalid content type'
      end

      it 'wrong headers returns an error' do
        body = {
          email: 'cool_email@gmail.com',
          password: 'cool password',
        }

        headers = {
          'Content-Type': 'something thats not application/json'
        }

        post '/api/v1/sessions', headers: headers, params: body

        expect(response).to_not be_successful
        expect(response).to have_http_status 400
        full_response = JSON.parse(response.body, symbolize_names: true) 

        expect(full_response).to have_key :error
        expect(full_response[:error]).to eq 'invalid content type'
      end
    end

    before :each do
      User.create!(email: '123@gmail.com',
                   password: 'cool password',
                   password_confirmation: 'cool password',
                   api_key: '12345')

      @headers = { 'CONTENT_TYPE': 'application/json' }
    end

    it 'email is incorrect' do
      body = {
        email: '122@gmail.com',
        password: 'cool password'
      }

      post '/api/v1/sessions', headers: @headers, params: JSON.generate(body)
      
      expect(response).to_not be_successful
      expect(response).to have_http_status 401
      full_response = JSON.parse(response.body, symbolize_names: true) 

      expect(full_response).to have_key :error
      expect(full_response[:error]).to eq('bad credentials')
    end

    it 'password is incorrect' do
      body = {
        email: '123@gmail.com',
        password: 'cool_password'
      }

      post '/api/v1/sessions', headers: @headers, params: JSON.generate(body)
      
      expect(response).to_not be_successful
      expect(response).to have_http_status 401
      full_response = JSON.parse(response.body, symbolize_names: true) 

      expect(full_response).to have_key :error
      expect(full_response[:error]).to eq('bad credentials')
    end
  end
end
