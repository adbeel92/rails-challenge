# frozen_string_literal: true

require 'rails_helper'

describe 'POST /users', type: :request do
  context 'When a fully registered account exists' do
    let(:payload) do
      {
        first_name: 'Eduardo',
        last_name: 'Arenas',
        email: 'test@gmail.com',
        password: 'password123'
      }
    end

    context 'a successful response' do
      before(:each) do
        post '/api/v1/users', params: payload
      end

      it 'has the expected header on response' do
        expect(response).to have_http_status(:success)
        expect(response.headers['X-Authorization']).to be
      end
    end

    context 'an invalid response' do
      context 'new email' do
        it 'has the expected error code on failure' do
          tmp_payload = payload.dup
          tmp_payload[:password] = ''
          post '/api/v1/users', params: tmp_payload

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.headers['X-Authorization']).not_to be
        end

        it 'has the expected error code on failure' do
          tmp_payload = payload.dup
          tmp_payload[:email] = 'invalid_email'
          post '/api/v1/users', params: tmp_payload

          expect(response).to have_http_status(:bad_request)
          expect(response.headers['X-Authorization']).not_to be
        end
      end

      context 'existing email' do
        let!(:user) { create(:user) }

        it 'has the expected error code on failure' do
          tmp_payload = payload.dup
          tmp_payload[:email] = user.email
          post '/api/v1/users', params: tmp_payload

          expect(response).to have_http_status(:bad_request)
          expect(response.headers['X-Authorization']).not_to be
        end
      end
    end
  end
end
