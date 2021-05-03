# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::Operations::Create do
  describe '#run' do
    let(:user) { create(:user) }
    let(:payload) do
      {
        user: user,
        original_url: Faker::Internet.url
      }
    end

    context 'When a link is new' do
      it 'should return true' do
        creator = Links::Operations::Create.new(payload)

        expect(creator.run).to eq(true)
        expect(creator.link.class).to eq(Link)
        expect(creator.link.original_url).to eq(payload[:original_url])
      end

      it 'should return false' do
        tmp_payload = payload.dup
        tmp_payload[:original_url] = 'invalid_url'
        creator = Links::Operations::Create.new(tmp_payload)

        expect(creator.run).to eq(false)
      end
    end

    context 'When the original_url already exists' do
      let!(:link) { create(:link) }

      it 'should raise error' do
        tmp_payload = payload.dup
        tmp_payload[:original_url] = link.original_url
        creator = Links::Operations::Create.new(tmp_payload)

        expect(creator.run).to eq(false)
      end
    end
  end
end
