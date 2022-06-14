require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it { should have_secure_password }
    it { should validate_presence_of :password_digest }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should validate_presence_of :api_key }
  end

  context 'class methods' do
    it '.build_from_request initializes a user from a JSON payload' do
      payload = { 
        email: '123@gmail.com', 
        password: '12345', 
        password_confirmation: '12345' 
      }.to_json
  
      user = User.build_from_request(payload)
      # is there a different way to test that the user has not yet been saved in the database?
      expect(user).to be_a User
      expect(user.id).to be_nil
    end
  end

  context 'instance methods' do
    describe '.valid_and_confirmed_password?' do
      it 'returns true if all validations pass and password matches confirmation' do
        user = User.new(email: '123@gmail.com', password: '12345', password_confirmation: '12345', api_key: '54321')

        expect(user.valid_and_confirmed_password?).to be true
      end

      it 'returns false if not' do
        User.create!(email: 'taken@gmail.com', password_digest: 'pe8r234braw908ef0', api_key: '34p89efoogan43234')
        user1 = User.new(email: '123@gmail.com', password: '11345', password_confirmation: '12345')
        user2 = User.new(email: '123@gmail.com', password: '12345', password_confirmation: '12245')
        user3 = User.new(email: 'taken@gmail.com', password: '12345', password_confirmation: '12345')

        expect(user1.valid_and_confirmed_password?).to be false
        expect(user2.valid_and_confirmed_password?).to be false
        expect(user3.valid_and_confirmed_password?).to be false
      end
    end
  end
end
