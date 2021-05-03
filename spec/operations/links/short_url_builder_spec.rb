# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::Operations::ShortUrlBuilder do
  describe '.encode_link_url' do
    let!(:link) { create(:link) }

    context do
      it 'success' do
        encoded_link_url = Links::Operations::ShortUrlBuilder.encode_link_url(link)

        expect(encoded_link_url).to match(Regexp::ALPHANUMERIC)
      end
    end
  end

  describe '.decode_link_url' do
    context do
      it 'success' do
        decoded_link_url = Links::Operations::ShortUrlBuilder.decode_link_url('swkiyZJ')

        expect(decoded_link_url[:id]).equal? '123'
      end
    end
  end
end
