# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::Queries::LinkByShortUrl do
  describe '#run' do
    let!(:link) { create(:link, id: 203) }

    context do
      it 'success' do
        result = Links::Queries::LinkByShortUrl.new(short_url: 'swkks55').run

        expect(result.id).equal? 203
      end
    end
  end
end
