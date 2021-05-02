# frozen_string_literal: true

require 'rails_helper'

describe 'GET /users/:id', type: :request do
  context 'When a user account exists' do
    include_context 'auth_context'

    let!(:user) { create(:user) }

    context 'unauthorized' do
      it 'responds unauthorized when you are not logged in' do
        get "/api/v1/users/#{user.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authorized' do
      let(:authorization_header) { auth_header(user.reload) }

      context 'a successful response' do
        before(:each) do
          get "/api/v1/users/#{user.id}", headers: authorization_header
        end

        it 'has user info in the response' do
          expect(response).to have_http_status(:success)
          expect(json_response['uuid']).to eq(user.uuid)
          expect(json_response['email']).to eq(user.email)
        end
      end

      context 'an invalid response' do
        let(:another_user) { create(:user, email: 'new@email.com') }

        it 'has an no-existing user' do
          get '/api/v1/users/0', headers: authorization_header

          expect(response).to have_http_status(:not_found)
        end

        it 'has an unauthorized user' do
          get "/api/v1/users/#{another_user.id}", headers: authorization_header

          expect(response).to have_http_status(:forbidden)
        end
      end
    end
  end
end
