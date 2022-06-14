require 'rails_helper'

RSpec.describe 'Registering a User' do
  context 'happy path tests' do
    before :each do
      body = {
        email: 'cool_email@gmail.com',
        password: 'cool password',
        password_confirmation: 'cool password'
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(body) 

      @full_response = JSON.parse(response.body, symbolize_names: true) 
    end

    it 'has status code 201' do
      expect(response).to be_successful
      expect(response).to have_http_status 201
    end

    it 'has user info in a data hash' do
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
      expect(attributes[:email]).to be_a String

      expect(attributes).to have_key :api_key
      expect(attributes[:api_key]).to be_a String

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
          password_confirmation: 'cool password'
        }

        post '/api/v1/users', headers: {}, params: body

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
          password_confirmation: 'cool password'
        }

        headers = {
          'Content-Type': 'something thats not application/json'
        }

        post '/api/v1/users', headers: headers, params: body

        expect(response).to_not be_successful
        expect(response).to have_http_status 400
        full_response = JSON.parse(response.body, symbolize_names: true) 

        expect(full_response).to have_key :error
        expect(full_response[:error]).to eq 'invalid content type'
      end
    end

    it 'email can not be missing' do
      body = {
        email: nil,
        password: 'cool password',
        password_confirmation: 'cool password'
      }

      headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }

      post '/api/v1/users', headers: headers, params: JSON.generate(body)

      expect(response).to_not be_successful
      expect(response).to have_http_status 400
      full_response = JSON.parse(response.body, symbolize_names: true) 

      expect(full_response).to have_key :error
      expect(full_response[:error]).to eq 'email can not be missing'
    end

    context 'passwords must match' do
      it 'mismatched passwords return an error' do
        body = {
          email: 'cool_email@gmail.com',
          password: 'cool password',
          password_confirmation: 'cool_password'
        }

        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }

        post '/api/v1/users', headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response).to have_http_status 400
        full_response = JSON.parse(response.body, symbolize_names: true) 

        expect(full_response).to have_key :error
        expect(full_response[:error]).to eq 'passwords must match'
      end

      it 'missing password returns an error' do
        body = {
          email: 'cool_email@gmail.com',
          password: '',
          password_confirmation: 'cool_password'
        }

        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }

        post '/api/v1/users', headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response).to have_http_status 400
        full_response = JSON.parse(response.body, symbolize_names: true) 

        expect(full_response).to have_key :error
        expect(full_response[:error]).to eq 'passwords must match'
      end

      it 'missing confirmation returns an error' do
        body = {
          email: 'cool_email@gmail.com',
          password: 'cool password',
          password_confirmation: ''
        }

        headers = {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }

        post '/api/v1/users', headers: headers, params: JSON.generate(body)

        expect(response).to_not be_successful
        expect(response).to have_http_status 400
        full_response = JSON.parse(response.body, symbolize_names: true) 

        expect(full_response).to have_key :error
        expect(full_response[:error]).to eq 'passwords must match'
      end
    end
  end
end
