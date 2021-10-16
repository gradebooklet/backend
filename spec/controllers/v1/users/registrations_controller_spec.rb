require 'rails_helper'

describe V1::Users::RegistrationController, type: :request do

  let (:user) { build_user }
  let (:existing_user) { create_user }
  let (:signup_url) { '/v1/sign_up' }

  context 'When creating a new user' do
    before do
      post signup_url, params: {
        user: {
          email: user.email,
          password: user.password,
          username: user.username
        }
      }
    end

    it 'returns 201' do
      expect(response.status).to eq(201)
    end

    it 'returns a token' do
      expect(response.headers['Access-Token']).to be_present
      expect(response.headers['Refresh-Token']).to be_present
      expect(response.headers['Expire-At']).to be_present
    end

    it 'returns the user email' do
      expect(json['data']).to have_attribute(:email).with_value(user.email)
    end
  end

  context 'When an email already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(400)
    end
  end

  context 'When an username already exists' do
    before do
      post signup_url, params: {
        user: {
          email: existing_user.email,
          password: existing_user.password
        }
      }
    end

    it 'returns 400' do
      expect(response.status).to eq(400)
    end
  end

end