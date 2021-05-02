# frozen_string_literal: true

require 'rails_helper'

describe 'POST /sessions', type: :request do
  context 'When a fully registered account exists' do
    let!(:user) { create(:user, password: 'password123') }

    context 'a successful response' do
      before(:each) do
        post '/api/v1/sessions', params: { email: user.email, password: 'password123' }
      end

      it 'has the expected header on response' do
        expect(response).to have_http_status(:success)
        expect(response.headers['X-Authorization']).to be
      end
    end

    context 'an invalid response' do
      it 'has the expected error code on failure' do
        post '/api/v1/sessions', params: { email: user.email, password: 'anything' }

        expect(response).to have_http_status(:bad_request)
        expect(response.headers['X-Authorization']).not_to be
      end

      it 'has the expected error code on failure' do
        post '/api/v1/sessions', params: { email: 'email', password: 'password' }

        expect(response).to have_http_status(:bad_request)
        expect(response_message).equal? 'email is invalid'
      end
    end
  end
end
