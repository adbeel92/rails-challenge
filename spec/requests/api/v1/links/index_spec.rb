# frozen_string_literal: true

require 'rails_helper'

describe 'GET /users/:user_id/links', type: :request do
  context 'When a user account exists' do
    include_context 'auth_context'

    let(:link) { create(:link) }
    let!(:user) { link.user }

    context 'unauthorized' do
      it 'responds unauthorized when you are not logged in' do
        get "/api/v1/users/#{user.id}/links"

        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authorized' do
      let(:authorization_header) { auth_header(user.reload) }

      context 'a successful response' do
        before(:each) do
          get "/api/v1/users/#{user.id}/links", headers: authorization_header
        end

        it 'has user info in the response' do
          expect(response).to have_http_status(:success)
          expect(json_response.size).to eq(1)
        end
      end
    end
  end
end
