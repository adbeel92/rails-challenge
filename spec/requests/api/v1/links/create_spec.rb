# frozen_string_literal: true

require 'rails_helper'

describe 'POST /users/:user_id/links', type: :request do
  context 'When a user account exists' do
    include_context 'auth_context'

    let(:user) { create(:user) }
    let(:payload) do
      {
        original_url: Faker::Internet.url
      }
    end

    context 'unauthorized' do
      it 'responds unauthorized when you are not logged in' do
        post "/api/v1/users/#{user.id}/links"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authorized' do
      let(:authorization_header) { auth_header(user.reload) }

      context 'a successful response' do
        before(:each) do
          post "/api/v1/users/#{user.id}/links", headers: authorization_header, params: payload
        end

        it 'has user info in the response' do
          expect(response).to have_http_status(:success)
          expect(json_response['original_url']).to eq(payload[:original_url])
          expect(json_response['shortened_url']).to be
        end
      end
    end
  end
end
