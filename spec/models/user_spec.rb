require 'rails_helper'

RSpec.describe User do
  context 'validations' do
    it { should have_secure_password }
    it { should validate_presence_of :password_digest }

    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }

    it { should validate_presence_of :api_key }
  end
end
