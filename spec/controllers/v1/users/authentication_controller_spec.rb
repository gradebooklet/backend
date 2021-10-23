require 'rails_helper'

describe V1::Users::AuthenticationController, type: :request do

  let (:user) { create_user }
  let (:login_url) { '/v1/sign_in' }
  let (:logout_url) { '/v1/sign_out' }

  context 'When logging in' do
    before do
      login_with_api(user)
    end

    it 'returns a token' do
      expect(response.headers['Access-Token']).to be_present
      expect(response.headers['Refresh-Token']).to be_present
      expect(response.headers['Expire-At']).to be_present
    end

    it 'returns 200' do
      expect(response.status).to eq(200)
    end
  end

  context 'When password is missing' do
    before do
      post login_url, params: {
        user: {
          email: user.email,
          password: nil
        }
      }
    end

    it 'returns 401' do
      expect(response.status).to eq(422)
    end

  end

  context 'When logging out' do
    it 'returns 204' do
      delete logout_url

      expect(response).to have_http_status(401)
    end
  end

end
