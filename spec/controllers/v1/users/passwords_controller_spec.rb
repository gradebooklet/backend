require 'rails_helper'

describe V1::Users::PasswordsController, type: :request do

  let (:user) { build_user }
  let (:existing_user) { create_user }
  let (:request_password_reset_url) { '/v1/password_reset_request' }
  let (:reset_password_url) { '/v1/reset_password' }

  context 'When requesting password reset and' do
    context 'user exists' do
      before do
        post request_password_reset_url, params: {
          user: {
            email: existing_user.email,
          }
        }
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
        expect(response.body).to eq("{\"status\":\"success\",\"message\":\"Link has been sent if user exists\"}")
      end
    end

    context 'user exists but already has valid reset token' do
      before do
        existing_user.generate_password_token!

        post request_password_reset_url, params: {
          user: {
            email: existing_user.email,
          }
        }
      end

      after do
        existing_user.reset_password_token = nil
        existing_user.reset_password_sent_at = nil
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
        expect(response.body).to eq("{\"status\":\"success\",\"message\":\"Link has been sent if user exists\"}")
      end
    end

    context "user doesnt exist and" do
      before do
        post request_password_reset_url, params: {
          user: {
            email: user.email,
          }
        }
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
        expect(response.body).to eq("{\"status\":\"success\",\"message\":\"Link has been sent if user exists\"}")
      end
    end
  end

  context 'When resetting a password' do
    context 'reset token valid' do
      before do
        existing_user.generate_password_token!
        new_password = 'VerySecurePassword'

        post reset_password_url, params: {
          user: {
            email: existing_user.email,
            password: new_password,
            reset_token: existing_user.reset_password_token
          }
        }
      end

      after do
        existing_user.reset_password_token = nil
        existing_user.reset_password_sent_at = nil
      end

      it 'returns 200' do
        expect(response.status).to eq(200)
        expect(response.body).to include(existing_user.username)
      end
    end

    context 'reset token invalid' do
      before do
        existing_user.generate_password_token!
        new_password = 'VerySecurePassword'

        post reset_password_url, params: {
          user: {
            email: existing_user.email,
            password: new_password,
            reset_token: '9vuaja8f8bnal48af'
          }
        }
      end

      after do
        existing_user.reset_password_token = nil
        existing_user.reset_password_sent_at = nil
      end

      it 'returns 200' do
        expect(response.status).to eq(422)
        expect(response.body).to eq("{\"status\":\"error\",\"error\":\"Token or Email invalid\"}")
      end
    end

  end

end