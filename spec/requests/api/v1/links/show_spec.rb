# frozen_string_literal: true

require 'rails_helper'

describe 'GET /users/:user_id/links/:id', type: :request do
  context 'When a user account exists' do
    include_context 'auth_context'

    let(:link) { create(:link) }
    let!(:user) { link.user }

    context 'unauthorized' do
      it 'responds unauthorized when you are not logged in' do
        get "/api/v1/users/#{user.id}/links/#{link.id}"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authorized' do
      let(:authorization_header) { auth_header(user.reload) }

      context 'a successful response' do
        before(:each) do
          get "/api/v1/users/#{user.id}/links/#{link.id}", headers: authorization_header
        end

        it 'has user info in the response' do
          expect(response).to have_http_status(:success)
          expect(json_response['original_url']).to eq(link.original_url)
        end
      end

      context 'an invalid response' do
        let(:another_user) { create(:user, email: 'new@email.com') }
        let(:another_link) { create(:link, user: another_user) }

        it 'has an no-existing link' do
          get "/api/v1/users/#{user.id}/links/0", headers: authorization_header

          expect(response).to have_http_status(:not_found)
        end

        it 'has an unauthorized link' do
          get "/api/v1/users/#{user.id}/links/#{another_link.id}", headers: authorization_header

          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end
