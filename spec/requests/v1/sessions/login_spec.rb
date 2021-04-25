# frozen_string_literal: true

require 'rails_helper'

describe 'POST /sessions', type: :request do
  context 'When a fully registered account exists' do
    let!(:user) { create(:user) }

    context 'a successful response' do
      before(:each) do
        post '/api/v1/sessions', params: { email: user.email, password: 'password' }
      end

      it 'has the expected header on response' do
        expect(response).to have_http_status(:success)
        expect(json_response).to be true
      end
    end

    context 'an invalid response' do
      it 'has the expected error code on failure' do
        post '/api/v1/sessions', params: { email: 'email', password: 'password' }

        expect(response).to have_http_status(:bad_request)
        expect(response_message).to be 'email is invalid'
      end
    end
  end
end
