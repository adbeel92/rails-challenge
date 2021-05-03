# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'GET /show' do
    context 'success' do
      let!(:link) { create(:link, id: 321) }

      it 'returns http success' do
        get '/swkiz2V'

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(link.original_url)
      end
    end

    context 'unsuccess' do
      it 'returns http success' do
        get '/abc'

        expect(response).to have_http_status(:not_found)
        expect(response_message).equal? 'link not found'
      end
    end
  end
end
